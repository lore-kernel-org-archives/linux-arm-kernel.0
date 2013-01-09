From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Jan 2013 00:41:42 +0100
Subject: [RFC PATCH 0/7] Initial Device Tree support for S3C64xx
Message-ID: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an initial proposal of Device Tree support for Samsung S3C64xx
SoC series.

It fixes several problems preventing from booting an S3C64xx-based system
using Device Tree, adds all the infrastructure for Device Tree-based board
support, including mach-s3c64xx-dt and dts include files for S3C64xx SoCs, and
(very) basic device tree source for FriendlyARM Mini6410 board.

Current support is very limited and allows only basic bootup to the point of
mounting rootfs, which fails, because there are no storage devices available,
but should be fine as a start and will be extended in future, hopefully with
help of all S3C64xx board maintainers.

Tomasz Figa (7):
  ARM: common: vic: Parse interrupt and resume masks from device tree
  ARM: common: vic: Fix invalid first IRQ number in OF-based
    registration
  ARM: s3c64xx: Add support for OF-based VIC initialization
  ARM: s3c64xx: Fix build error with CONFIG_S3C_DEV_FB disabled
  ARM: s3c64xx: Add board file for boot using Device Tree
  ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
  ARM: dts: Add dts file for S3C6410-based Mini6410 board

 Documentation/devicetree/bindings/arm/vic.txt |  6 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/s3c6400.dtsi                | 33 ++++++++++
 arch/arm/boot/dts/s3c6410-mini6410.dts        | 44 +++++++++++++
 arch/arm/boot/dts/s3c6410.dtsi                | 33 ++++++++++
 arch/arm/boot/dts/s3c64xx.dtsi                | 73 +++++++++++++++++++++
 arch/arm/common/vic.c                         |  9 ++-
 arch/arm/mach-s3c64xx/Kconfig                 | 13 ++++
 arch/arm/mach-s3c64xx/Makefile                |  1 +
 arch/arm/mach-s3c64xx/common.c                | 20 +++++-
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c       | 93 +++++++++++++++++++++++++++
 arch/arm/mach-s3c64xx/pm.c                    |  4 +-
 12 files changed, 323 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
 create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
 create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
 create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
 create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c

-- 
1.8.1
