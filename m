From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  2 Aug 2013 12:38:20 +0200
Subject: [PATCH 0/7] ARM: imx27 pinctrl
Message-ID: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this series implements a imx27 pinctrl driver. imx1/21/27 have a register
format that is not compatible with the rest of imx series processors. The
series adds a imx1 core driver for the different register layout.

The gpio data registers are between iomux control registers. In this series,
the gpio devices are initialized as subdevices of the iomux device, sharing the
mapped registers.

Regards,

Markus


Changes since RFC:
 - Moved imx1 specific register format functions into a seperate core driver
 - Rebased onto gpio/for-next and dropping gpio-mxc devm patch


Markus Pargmann (7):
      gpio: mxc: Support initialization as subdevice
      pinctrl: imx header, conditional probe functions
      pinctrl: imx1 core driver
      pinctrl: imx27: imx27 pincontrol driver
      ARM: dts: imx27 pin functions
      ARM: dts: imx27 pinctrl
      ARM: imx27: enable pinctrl

 .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  53 ++
 arch/arm/boot/dts/imx27-pinfunc.h                  | 520 ++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       | 216 +++++--
 arch/arm/mach-imx/Kconfig                          |   2 +
 drivers/gpio/gpio-mxc.c                            |  18 +-
 drivers/pinctrl/Kconfig                            |  13 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-imx.h                      |   4 +
 drivers/pinctrl/pinctrl-imx1-core.c                | 667 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-imx1.h                     |  23 +
 drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++
 include/linux/platform_data/gpio-mxc.h             |  17 +
 12 files changed, 1950 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx1-core.c
 create mode 100644 drivers/pinctrl/pinctrl-imx1.h
 create mode 100644 drivers/pinctrl/pinctrl-imx27.c
 create mode 100644 include/linux/platform_data/gpio-mxc.h
