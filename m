From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  1 Sep 2013 09:28:01 +0200
Subject: [PATCH v3 0/7] ARM: imx27 pinctrl
Message-ID: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series implements a imx27 pinctrl driver. imx1/21/27 have a register
format that is not compatible with the rest of imx series processors. The
series adds a imx1 core driver for the different register layout.

Regards,

Markus

Changes since v2:
 - Some fixes in dts files and documentation

Changes since v1:
 - Removed changes of gpio-mxc driver
 - imx and imx1-core drivers are completely seperated now
 - Splitted DT pinctrl entries into imx27.dtsi and board files
 - Other style changes

Markus Pargmann (7):
      pinctrl: imx1 core driver
      pinctrl: imx27: imx27 pincontrol driver
      ARM: dts: imx27 pin functions
      ARM: dts: imx27 pinctrl
      ARM: dts: imx27 phyCARD-S pinctrl
      ARM: dts: imx27 phycore pinctrl
      ARM: imx27: enable pinctrl

 .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  50 ++
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |  10 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   4 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts     |   6 +
 arch/arm/boot/dts/imx27-pinfunc.h                  | 524 +++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       | 102 ++++
 arch/arm/mach-imx/Kconfig                          |   2 +
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-imx1-core.c                | 649 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-imx1.h                     |  73 +++
 drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++
 13 files changed, 1914 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx1-core.c
 create mode 100644 drivers/pinctrl/pinctrl-imx1.h
 create mode 100644 drivers/pinctrl/pinctrl-imx27.c
