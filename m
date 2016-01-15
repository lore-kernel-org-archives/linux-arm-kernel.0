From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 15 Jan 2016 11:37:53 +0900
Subject: [PATCH v3 00/14] r8a7793, gose: Add audio support to device tree
Message-ID: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support to r8a7793 and gose device trees for
rcar sound: first in PIO mode then using DMA

I have been unable to test if audio works (in PIO mode) as I
do not have physical access to a gose board. I would appreciate
some assistance there.

This work is based heavily on the work of others for the r8a7791 and
koelsch as noted in the changelogs of individual patches.

This series is based on renesas-devel-20160111-v4.4 and
has no other dependencies that I am aware of.

Changes between v2 and v3
* Minor changelog tweaks

Changes since v1 and v2:
* Dropped RFC designation
* Dropped i2c patches: they have been posted and partially merged separately
* Dropped MIX/CTU support pending more work on that feature
* Enable Audio DMAC peri peri via sound driver
* Other changes noted in per-patch changelogs


Simon Horman (14):
  ARM: shmobile: r8a7793: add MSTP10 clocks to device tree
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

 arch/arm/boot/dts/r8a7793-gose.dts        |  88 +++++++++
 arch/arm/boot/dts/r8a7793.dtsi            | 289 +++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7793-clock.h |   2 +
 3 files changed, 376 insertions(+), 3 deletions(-)

-- 
2.1.4
