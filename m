From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:27:35 +1100
Subject: [PATCH v2 00/13] r8a7793, gose: Add audio support to device tree
Message-ID: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support to r8a7793 and gose device trees for
rcar sound: first in PIO mode then using DMA

I have been unable to test if audio works (in PIO mode) as I
do not have physical access to a gose board. I would appreciate
some assistance there too.

This work is based heavily on the work of others for the r8a7791 and
koelsch as noted in the changelogs of individual patches.

This series is based on renesas-devel-20160105-v4.4-rc8.

This series depends on:

* [PATCH] ARM: shmobile: r8a7793: move dmac nodes
* [PATCH v2] ARM: shmobile: gose: add i2c2 bus to device tree

Changes since v1:
* Dropped RFC designation
* Dropped i2c patches: they have been posted and partially merged separately
* Dropped MIX/CTU support pending more work on that feature
* Enable Audio DMAC peri peri via sound driver
* Other changes noted in per-patch changelogs


Simon Horman (13):
  ARM: shmobile: r8a7793: add audio clock to device tree
  ARM: shmobile: r8a7793: add m2 clock to device tree
  ARM: shmobile: r8a7793: add R-Car sound support to device tree
  ARM: shmobile: r8a7793: add DVC support to device tree
  ARM: shmobile: r8a7793: add audio DMAC clocks to device tree
  ARM: shmobile: r8a7793: add audio DMAC to device tree
  ARM: shmobile: r8a7793: enable Audio DMAC peri peri via sound driver
  ARM: shmobile: gose: Enable sound PIO support in device tree
  ARM: shmobile: gose: enable sound DMA support in device tree
  ARM: shmobile: gose: enable sound DMA support via BUSIF in device tree
  ARM: shmobile: gose: enable sound DMA support via SRC in device tree
  ARM: shmobile: gose: enable sound DMA support via DVC in device tree
  ARM: shmobile: r8a7793: enable audio DMAC in device tree

 arch/arm/boot/dts/r8a7793-gose.dts |  88 +++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     | 253 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 338 insertions(+), 3 deletions(-)

-- 
2.1.4
