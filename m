From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Sat, 18 Apr 2015 05:28:45 +0800
Subject: [PATCH v3 00/10] Add Freescale i.mx7d support
Message-ID: <1429306135-24695-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

add basic support for chip imx7d.
 - MSL
 - Clock support. All clock enabled.
 - pinctrl support
 - SD Card support

Change from v2 to v3
  - remove unsupport part in imx7d-sdb.dtb

Change from V1 to V2:
  - split patch1 to three small one to avoid 100k maillist limitation.
  - fix imx7d.dtsi code style problem

Anson Huang (1):
  ARM: imx: add msl support for imx7d

Frank Li (9):
  ARM: dts: add pinfunc include file to support imx7d
  ARM: dts: add pinfunc include file gpio1 to support imx7d
  ARM: dts: add clock include file to support imx7d
  ARM: dts: add imx7d soc dtsi file
  pinctrl: add imx7d support
  ARM: imx: add gpt system timer support for imx7d
  ARM: imx: add imx7d clk tree support
  arm: dts: add imx7d-sdb support
  ARM: config: imx_v6_v7_defconfig add imx7d support

 arch/arm/boot/dts/Makefile                |    2 +
 arch/arm/boot/dts/imx7d-pinfunc.h         | 1153 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts           |  684 +++++++++++++++++
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
 25 files changed, 4902 insertions(+), 8 deletions(-)
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
