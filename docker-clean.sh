#!/bin/sh

echo -e "-- Removing exited containers --\n"
docker container prune -f

echo -e "\n\n-- Removing untagged images --\n"
docker image prune -f --filter "dangling=true"

echo -e "\n\n-- Removing volume directories --\n"
docker volume prune -f

echo -e "\n\n --Removing all images"
docker rmi -f $(docker images -a -q)
echo -e "\n\n -- Removing system prune"
docker rm $(docker ps -a -f status=exited -q)
docker system prune -a -f
docker images purge

docker volume rm $(docker volume ls -f dangling=true -q)
echo -e "\n\neEverything is clear."

#docker rmi $(docker ps -a -q) -f
#docker network rm $(docker network ls -q)
