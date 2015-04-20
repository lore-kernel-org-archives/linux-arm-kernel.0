From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 21 Apr 2015 05:05:22 +0800
Subject: [PATCH v4 00/11] Add Freescale i.mx7d support
Message-ID: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

add basic support for chip imx7d.
 - MSL
 - Clock support. All clock enabled.
 - pinctrl support
 - SD Card support

Change from v3 to v4
 - Fixed the problem review by Russel king.
   Remove __mxc_arch_type
   Remove MXC_ARCH_CA7
   use new smp_operation for ca7 platform
 - imx7d.dtsi remove unecessary part for bring up
 - imx7d-sdb.dsi, just enable uart i2c and sd card
 - Add device tree binding document for timer, clock and pinctrl

Change from v2 to v3
  - remove unsupport part in imx7d-sdb.dtb

Change from V1 to V2:
  - split patch1 to three small one to avoid 100k maillist limitation.
  - fix imx7d.dtsi code style problem


Anson Huang (1):
  ARM: imx: add msl support for imx7d

Frank Li (10):
  ARM: dts: add pinfunc include file to support imx7d
  ARM: dts: add pinfunc include file gpio1 to support imx7d
  ARM: dts: add clock include file to support imx7d
  Document: dt: binding: imx: update document for imx7d support
  ARM: dts: add imx7d soc dtsi file
  pinctrl: add imx7d support
  ARM: imx: add gpt system timer support for imx7d
  ARM: imx: add imx7d clk tree support
  arm: dts: add imx7d-sdb support
  ARM: config: imx_v6_v7_defconfig add imx7d support

 .../devicetree/bindings/clock/imx7d-clock.txt      |   13 +
 .../bindings/pinctrl/fsl,imx-pinctrl.txt           |    3 +
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         |   27 +
 .../devicetree/bindings/timer/fsl,imxgpt.txt       |    3 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 1153 ++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  405 +++++++
 arch/arm/boot/dts/imx7d.dtsi                       |  498 +++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |    1 +
 arch/arm/mach-imx/Kconfig                          |   11 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/anatop.c                         |    5 +-
 arch/arm/mach-imx/clk-imx7d.c                      |  885 +++++++++++++++
 arch/arm/mach-imx/clk-pllv3.c                      |   17 +-
 arch/arm/mach-imx/clk.h                            |    8 +
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/cpu.c                            |    3 +
 arch/arm/mach-imx/hardware.h                       |    7 +-
 arch/arm/mach-imx/mach-imx7d.c                     |   53 +
 arch/arm/mach-imx/mx7.h                            |   38 +
 arch/arm/mach-imx/mxc.h                            |    8 +-
 arch/arm/mach-imx/platsmp.c                        |   19 +
 arch/arm/mach-imx/time.c                           |    3 +-
 drivers/pinctrl/freescale/Kconfig                  |    7 +
 drivers/pinctrl/freescale/Makefile                 |    1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |    3 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |    1 +
 drivers/pinctrl/freescale/pinctrl-imx7d.c          |  411 +++++++
 include/dt-bindings/clock/imx7d-clock.h            |  450 ++++++++
 29 files changed, 4030 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
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
