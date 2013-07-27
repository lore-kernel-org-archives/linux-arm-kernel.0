From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 17:26:40 +0200
Subject: [RFC 0/8] ARM: imx27 pinctrl
Message-ID: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series implements a imx27 pinctrl driver. imx27/21 have a register format
that is not compatible with the rest of imx series processors. I added some
functions to support it within the core imx pinctrl driver.

The gpio data registers are between iomux control registers. In this series,
the gpio devices are initialized as subdevices of the iomux device, sharing the
mapped registers.

Regards,

Markus


Markus Pargmann (8):
      gpio: mxc: Use devm_ functions
      gpio: mxc: Support for initialization as submodule
      pinctrl: imx: Move private struct to header file
      pinctrl: imx: Support imx21 register format
      pinctrl: imx27: imx27 pincontrol driver
      ARM: imx27: enable pinctrl
      ARM: dts: imx27 pin functions
      ARM: dts: imx27 pinctrl

 .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  53 ++
 arch/arm/boot/dts/imx27-pinfunc.h                  | 520 +++++++++++++++++++
 arch/arm/boot/dts/imx27.dtsi                       | 217 +++++---
 arch/arm/mach-imx/Kconfig                          |   2 +
 drivers/gpio/gpio-mxc.c                            |  51 +-
 drivers/pinctrl/Kconfig                            |   8 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-imx.c                      | 272 +++++++++-
 drivers/pinctrl/pinctrl-imx.h                      |  12 +
 drivers/pinctrl/pinctrl-imx27.c                    | 553 +++++++++++++++++++++
 include/linux/gpio-mxc.h                           |  17 +
 11 files changed, 1597 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 drivers/pinctrl/pinctrl-imx27.c
 create mode 100644 include/linux/gpio-mxc.h
