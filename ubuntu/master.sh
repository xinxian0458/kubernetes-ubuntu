#!/bin/bash

# Copyright 2014 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# attempt to warn user about kube and etcd binaries
PATH=$PATH:/opt/bin:

if ! $(grep Ubuntu /etc/lsb-release > /dev/null 2>&1)
then
    echo "warning: not detecting a ubuntu system"
fi

if ! $(which etcd > /dev/null)
then
    echo "warning: etcd binary is not found in the PATH: $PATH"
fi

if ! $(which kube-apiserver > /dev/null) && ! $(which kube-controller-manager > /dev/null)
then
    echo "warning: kube binaries are not found in the $PATH"
fi

# copy /etc/init files
cp init_conf/etcd.conf /etc/init/
cp init_conf/flanneld_master.conf /etc/init/flanneld.conf
cp init_conf/kube-apiserver.conf /etc/init/
cp init_conf/kube-controller-manager.conf /etc/init/
cp init_conf/kube-scheduler.conf /etc/init/

# copy /etc/initd/ files
cp initd_scripts/etcd /etc/init.d/
cp initd_scripts/flanneld /etc/init.d/
cp initd_scripts/kube-apiserver /etc/init.d/
cp initd_scripts/kube-controller-manager /etc/init.d/
cp initd_scripts/kube-scheduler /etc/init.d/

# copy default configs
cp default_scripts/etcd /etc/default/
cp default_scripts/flanneld_master /etc/default/flanneld
cp default_scripts/kube-apiserver /etc/default/
cp default_scripts/kube-controller-manager /etc/default/
cp default_scripts/kube-scheduler /etc/default/

