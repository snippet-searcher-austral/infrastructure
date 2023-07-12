#!/bin/bash
GHCR_TOKEN="$1"
echo $GHCR_TOKEN | docker login ghcr.io -u matiaslcoulougian --password-stdin

if [ -z "$2" ]; then
  service nginx stop
 # Drop all existing containers, pull the latest images, and run the containers
  docker-compose down
  docker-compose pull
  docker-compose up -d
else
  # Stop and remove the existing container
  container="$2"
  docker-compose stop $container
  docker-compose rm $container

  # Pull the Docker image
  docker-compose pull $container

  # Run the Docker container
  docker-compose up -d $container

  #Restart the proxy
  docker-compose restart proxy
fi





