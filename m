From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 16 Apr 2015 06:30:09 +0800
Subject: [PATCH 0/7] Add Freescale i.mx7d support
Message-ID: <1429137016-21816-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add basic support for chip imx7d.
 - MSL
 - Clock support. All clock enabled.
 - pinctrl support
 - SD Card support

Anson Huang (1):
  ARM: imx: add msl support for imx7d

Frank Li (6):
  ARM: dts: add include file to support imx7d
  pinctrl: add imx7d support
  ARM: imx: add gpt system timer support for imx7d
  ARM: imx: add imx7d clk tree support
  arm: dts: add imx7d-sdb support
  ARM: config: imx_v6_v7_defconfig add imx7d support

 arch/arm/boot/dts/Makefile                |    2 +
 arch/arm/boot/dts/imx7d-pinfunc.h         | 1153 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts           |  723 ++++++++++++++++++
 arch/arm/boot/dts/imx7d.dtsi              | 1091 +++++++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig      |    1 +
 arch/arm/mach-imx/Kconfig                 |   11 +
 arch/arm/mach-imx/Makefile                |    1 +
 arch/arm/mach-imx/anatop.c                |   33 +-
 arch/arm/mach-imx/clk-imx7d.c             |  885 ++++++++++++++++++++++
 arch/arm/mach-imx/clk-pllv3.c             |   17 +-
 arch/arm/mach-imx/clk.h                   |    8 +
 arch/arm/mach-imx/common.h                |    1 +
 arch/arm/mach-imx/cpu.c                   |   10 +
 arch/arm/mach-imx/hardware.h              |    7 +-
 arch/arm/mach-imx/mach-imx7d.c            |   53 ++
 arch/arm/mach-imx/mx7.h                   |   38 +
 arch/arm/mach-imx/mxc.h                   |   15 +-
 arch/arm/mach-imx/platsmp.c               |   24 +-
 arch/arm/mach-imx/time.c                  |    3 +-
 drivers/pinctrl/freescale/Kconfig         |    7 +
 drivers/pinctrl/freescale/Makefile        |    1 +
 drivers/pinctrl/freescale/pinctrl-imx.c   |    3 +-
 drivers/pinctrl/freescale/pinctrl-imx.h   |    1 +
 drivers/pinctrl/freescale/pinctrl-imx7d.c |  411 ++++++++++
 include/dt-bindings/clock/imx7d-clock.h   |  450 +++++++++++
 25 files changed, 4941 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7d-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx7d-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx7d.dtsi
 create mode 100644 arch/arm/mach-imx/clk-imx7d.c
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c
 create mode 100644 arch/arm/mach-imx/mx7.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx7d.c
 create mode 100644 include/dt-bindings/clock/imx7d-clock.h

-- 
1.9.1
