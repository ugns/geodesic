ARG VERSION=latest
ARG OS=debian
ARG CLI_NAME=undergrid

FROM cloudposse/geodesic:$VERSION-$OS

# Install ubuntu universe repo so we can install more helpful packages
RUN apt-get install -y software-properties-common && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu bionic universe" && \
    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 3B4FE6ACC0B21F32 && \
    gpg --export --armor 3B4FE6ACC0B21F32 | apt-key add - && \
    apt-get update 

# Install Atmos
RUN apt-get update && apt-get install -y --allow-downgrades \
    atmos \
    vendir

# Geodesic message of the Day
ENV MOTD_URL=""

ENV AWS_VAULT_BACKEND=file

ENV DOCKER_IMAGE="ghcr.io/ugns/geodesic"
ENV DOCKER_TAG="latest"

# Geodesic banner
ENV BANNER="UnderGrid"

COPY rootfs/ /

WORKDIR /
