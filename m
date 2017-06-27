From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Jun 2017 17:46:06 -0500
Subject: [PATCH 0/4] Some remoteproc/rpmsg Kconfig cleanups
Message-ID: <20170627224610.15321-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

The following are some Kconfig related cleanups on rpmsg and remoteproc
to help resolve the current build related warnings reported on linux-next
after the rpmsg for-next merges. 

The first 2 patches drop the VIRTUALIZATION dependency (there is never
a true dependency) that were introduced a long while back to fix a
dependency issue on VIRTIO, and is no longer needed. This cleanup
results in the elimination of the ppc64_defconfig warnings against
the davinci remoteproc driver (davinci is ARMv5, and should have no
dependency against PPC arch whatsoever, that warning can be seen
without the keystone remoteproc patches).

The third patch is a pure cleanup patch, and the last patch is an
alternate fix for the linux-next Kconfig warnings, without your patch
to change the RPMSG_VIRTIO dependency [1]. Last patch can also go with
your patch, but feel free to drop it if picking up your patch instead.

Patches are based directly on linux-next 20170627 tag, They also apply
fine on mainline 4.12-rcs.

regards
Suman

[1] https://patchwork.kernel.org/patch/9810881/

Suman Anna (4):
  rpmsg: Drop VIRTUALIZATION dependency from RPMSG_VIRTIO
  remoteproc: Drop VIRTUALIZATION dependency from REMOTEPROC
  remoteproc: Drop redundant REMOTEPROC dependency from driver Kconfigs
  remoteproc/keystone: Fix circular dependencies for ARM configs

 drivers/remoteproc/Kconfig | 11 -----------
 drivers/rpmsg/Kconfig      |  1 -
 2 files changed, 12 deletions(-)

-- 
2.13.1
