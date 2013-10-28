From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Oct 2013 10:00:35 +0100
Subject: [PATCH v6 0/8] ARM: imx27 pinctrl
Message-ID: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

v6 updates the binding documentation.

this series implements a imx27 pinctrl driver. imx1/21/27 have a register
format that is not compatible with the rest of imx series processors. The
series adds a imx1 core driver for the different register layout.

Regards,

Markus


Markus Pargmann (8):
  pinctrl: imx1 core driver
  pinctrl: imx27: imx27 pincontrol driver
  ARM: dts: imx27 pin functions
  ARM: dts: imx27 pinctrl
  ARM: dts: imx27 phyCARD-S pinctrl
  ARM: dts: imx27 phycore move uart1 to rdk
  ARM: dts: imx27 phycore pinctrl
  ARM: imx27: enable pinctrl

 .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  89 +++
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |  10 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   4 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   5 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts     |   8 +-
 arch/arm/boot/dts/imx27-pinfunc.h                  | 524 +++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       | 102 ++++
 arch/arm/mach-imx/Kconfig                          |   2 +
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-imx1-core.c                | 653 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-imx1.h                     |  73 +++
 drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++
 13 files changed, 1958 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx1-core.c
 create mode 100644 drivers/pinctrl/pinctrl-imx1.h
 create mode 100644 drivers/pinctrl/pinctrl-imx27.c

-- 
1.8.4.rc3
