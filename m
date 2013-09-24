From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 24 Sep 2013 09:40:09 +0900
Subject: [GIT PULL 2/2] Samsung DT for S3C64XX
Message-ID: <0c4501ceb8be$9f064b90$dd12e2b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 66fcbe6b7c2827866100837611c9838298a28486:

  ARM: S3C64XX: Remove old clock management code (2013-09-17 06:47:36 +0900)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-s3c64xx

for you to fetch changes up to 2ec35a4252eae3d5277af041bd1b5ae4f6183cad:

  ARM: dts: Add dts file for S3C6410-based SMDK6410 board (2013-09-17
06:48:29 +0900)

----------------------------------------------------------------
Add device tree support for S3C64XX
- add device tree infrastructure for s3c64xx
- add DT SoC file for s3c64xx
- add DT board file for FriendlyARM Mini6410 board
- add DT board file for SAMSUNG SMDK6410

Based on Common Clk Framework for S3C64XX
- this branch is on top of v3.13-next/common-clk-s3c64xx

----------------------------------------------------------------
Tomasz Figa (7):
      irqchip: vic: Parse interrupt and resume masks from device tree
      ARM: S3C64XX: Bypass legacy initialization when booting with DT
      gpio: samsung: Skip initialization if device tree is present
      ARM: S3C64XX: Add board file for boot using Device Tree
      ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
      ARM: dts: Add dts file for S3C6410-based Mini6410 board
      ARM: dts: Add dts file for S3C6410-based SMDK6410 board

 Documentation/devicetree/bindings/arm/vic.txt |   12 +
 arch/arm/boot/dts/Makefile                    |    2 +
 arch/arm/boot/dts/s3c6400.dtsi                |   41 ++
 arch/arm/boot/dts/s3c6410-mini6410.dts        |  228 ++++++++
 arch/arm/boot/dts/s3c6410-smdk6410.dts        |  103 ++++
 arch/arm/boot/dts/s3c6410.dtsi                |   57 ++
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi        |  687
+++++++++++++++++++++++++
 arch/arm/boot/dts/s3c64xx.dtsi                |  199 +++++++
 arch/arm/mach-s3c64xx/Kconfig                 |   16 +
 arch/arm/mach-s3c64xx/Makefile                |    1 +
 arch/arm/mach-s3c64xx/common.c                |   12 +
 arch/arm/mach-s3c64xx/dma.c                   |    9 +
 arch/arm/mach-s3c64xx/irq-pm.c                |    9 +
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c       |   85 +++
 arch/arm/mach-s3c64xx/s3c6400.c               |    9 +
 arch/arm/mach-s3c64xx/s3c6410.c               |    9 +
 arch/arm/plat-samsung/init.c                  |   12 +-
 drivers/gpio/gpio-samsung.c                   |   34 +-
 drivers/irqchip/irq-vic.c                     |    7 +-
 19 files changed, 1503 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
 create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
 create mode 100644 arch/arm/boot/dts/s3c6410-smdk6410.dts
 create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
 create mode 100644 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
 create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
