From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 22:49:16 +0100
Subject: [GIT PULL v2] ARM: SoC fixes for 3.20-rc1
Message-ID: <9821137.y0s4hhuroe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 4a3a6f86693922b29cf829c63f652b057f14619e:

  ARM: multi_v7_defconfig: Enable shmobile platforms (2015-02-26 16:36:09 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 3.20-rc1

The arm-soc bug fixes this time around are mostly for the omap
platform, coming from a pull request from Tony Lindgren and are
almost entirely fixing dts files.

The other two changes enable support for the shmobile platform
in generic armv7 kernels and change some properties in the
ARM64 reference board dts files.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'fixes-v4.0-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Felipe Balbi (3):
      ARM: dts: am437x-idk: fix TPS62362 i2c bus
      ARM: omap2plus_defconfig: enable TPS62362 regulator
      ARM: dts: am437x-idk: fix sleep pinctrl state

Geert Uytterhoeven (1):
      ARM: multi_v7_defconfig: Enable shmobile platforms

Ivaylo Dimitrov (1):
      ARM: dts: n900: fix i2c bus numbering

Pali Roh?r (1):
      ARM: dts: n900: Fix offset for smc91x ethernet

Peter Ujfalusi (5):
      ARM: dts: omap2: Correct the dma controller's property names
      ARM: dts: omap3: Correct the dma controller's property names
      ARM: dts: omap4: Correct the dma controller's property names
      ARM: dts: omap5: Correct the dma controller's property names
      ARM: dts: dra7: Correct the dma controller's property names

Robert Nelson (1):
      ARM: dts: am335x-bone*: usb0 is hardwired for peripheral

Roger Quadros (5):
      ARM: dts: DRA7: Fix SATA PHY node
      ARM: dts: OMAP5: Fix SATA PHY node
      ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
      ARM: omap2plus_defconfig: Fix SATA boot
      ARM: dts: dra7x-evm: beagle-x15: Fix USB Host

Sudeep Holla (1):
      arm64: Add L2 cache topology to ARM Ltd boards/models

Tony Lindgren (1):
      ARM: dts: Fix USB dts configuration for dm816x

 arch/arm/boot/dts/am335x-bone-common.dtsi  |  1 +
 arch/arm/boot/dts/am437x-idk-evm.dts       | 25 +--------
 arch/arm/boot/dts/am57xx-beagle-x15.dts    |  8 ---
 arch/arm/boot/dts/dm8168-evm.dts           | 25 +++++++++
 arch/arm/boot/dts/dm816x.dtsi              | 34 +++++++++++--
 arch/arm/boot/dts/dra7-evm.dts             |  8 ---
 arch/arm/boot/dts/dra7.dtsi                |  8 +--
 arch/arm/boot/dts/dra72-evm.dts            |  8 ---
 arch/arm/boot/dts/omap2.dtsi               |  4 +-
 arch/arm/boot/dts/omap3-n900.dts           |  9 +++-
 arch/arm/boot/dts/omap3.dtsi               |  4 +-
 arch/arm/boot/dts/omap4.dtsi               |  4 +-
 arch/arm/boot/dts/omap5.dtsi               |  8 +--
 arch/arm/configs/multi_v7_defconfig        | 82 ++++++++++++++++++++++++++++--
 arch/arm/configs/omap2plus_defconfig       |  4 +-
 arch/arm64/boot/dts/arm/foundation-v8.dts  |  8 +++
 arch/arm64/boot/dts/arm/juno.dts           | 14 +++++
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts |  8 +++
 18 files changed, 190 insertions(+), 72 deletions(-)
