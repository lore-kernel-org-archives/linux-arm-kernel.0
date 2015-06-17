From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 17 Jun 2015 23:39:21 +0800
Subject: [PATCH 0/8] add basic support for i.mx6 ul chip
Message-ID: <1434555569-8237-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add basic function support i.mx6ul.
add simple dts.
add full pin function define
add clock support.
add low level debug

Anson Huang (1):
  ARM: imx: add low-level debug support for i.mx6ul

Frank Li (7):
  ARM: imx: add i.mx6ul msl support
  ARM: imx: add imx6ul clk tree support
  Document: dt: binding: imx: update document for imx6ul support
  ARM: pinctrl: imx: add i.mx6ul pinctrl driver
  ARM: dts: add i.mx6ul pin function include file
  ARM: dts: imx: add imx6ul and imx6ul evk board support
  ARM: imx: imx_v6_v7_defconfig enable imx6ul support

 .../devicetree/bindings/clock/imx6ul-clock.txt     |  13 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |  36 +
 arch/arm/Kconfig.debug                             |   9 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             | 337 ++++++++
 arch/arm/boot/dts/imx6ul-pinfunc.h                 | 938 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi                      | 645 ++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   1 +
 arch/arm/include/debug/imx-uart.h                  |  13 +
 arch/arm/mach-imx/Kconfig                          |   8 +
 arch/arm/mach-imx/Makefile                         |   1 +
 arch/arm/mach-imx/mach-imx6ul.c                    |  43 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx6ul.c                       | 436 ++++++++++
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx6ul.c         | 323 +++++++
 include/dt-bindings/clock/imx6ul-clock.h           | 240 ++++++
 18 files changed, 3054 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6ul-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ul.dtsi
 create mode 100644 arch/arm/mach-imx/mach-imx6ul.c
 create mode 100644 drivers/clk/imx/clk-imx6ul.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx6ul.c
 create mode 100644 include/dt-bindings/clock/imx6ul-clock.h

-- 
1.9.1
