From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:37 +0900
Subject: [PATCH/RFC 00/19] r8a7793,
 gose: Add i2c and audio support to device tree
Message-ID: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support to r8a7793 and gose device trees for:
* i2c and iic
* rcar sound: first in PIO mode then using DMA

i2c support is a pre-requisite for rcar sound support.

Unfortunately there appears to be some problem with DMA
for rcar sound that I have been unable to track down. On booting I see:

rcar_sound ec500000.sound: dma allocate failed
rcar_sound ec500000.sound: ssi[0] fallback to PIO mode
rcar_sound ec500000.sound: ssi[1] fallback to PIO mode
rcar_sound ec500000.sound: probed

I would appreciate any insights regarding the above.

I have been unable to test if audio works (in PIO mode) as I
do not have physical access to a gose board. I would appreaciate
some assistance there too.

This work is based heavily on the work of others for the r8a7791 and
koelsch.  as noted in the changelogs of individual patches.

This series is based on renesas-devel-20151211-v4.4-rc4.


Simon Horman (19):
  ARM: shmobile: r8a7793: add i2c clocks
  ARM: shmobile: r8a7793: add i2c to device tree
  ARM: shmobile: gose: add i2c2 bus to device tree
  ARM: shmobile: r8a7793: add iic(b)  to device tree
  ARM: shmobile: r8a7793: add MSTP10 clocks to device tree
  ARM: shmobile: r8a7793: add audio clock to device tree
  ARM: shmobile: r8a7793: add m2 clock to device tree
  ARM: shmobile: r8a7793: add R-Car sound support to device tree
  ARM: shmobile: r8a7793: add DVC support to device tree
  ARM: shmobile: r8a7793: add audio DMAC clocks to device tree
  ARM: shmobile: r8a7793: add audio DMAC to device tree
  ARM: shmobile: gose: Enable sound PIO support in device tree
  ARM: shmobile: gose: enable sound DMA support in device tree
  ARM: shmobile: gose: enable sound DMA support via BUSIF in device tree
  ARM: shmobile: gose: enable sound DMA support via SRC in device tree
  ARM: shmobile: gose: enable sound DMA support via DVC in device tree
  ARM: shmobile: r8a7793: enable audio DMAC in device tree
  ARM: shmobile: r8a7793: Add Audio CTU support to device tree
  ARM: shmobile: r8a7793: add Audio MIX support to device tree

 arch/arm/boot/dts/r8a7793-gose.dts        | 107 ++++++++
 arch/arm/boot/dts/r8a7793.dtsi            | 437 +++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7793-clock.h |   2 +
 3 files changed, 539 insertions(+), 7 deletions(-)

-- 
2.1.4
