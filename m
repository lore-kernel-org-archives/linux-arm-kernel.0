From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 14 Oct 2014 23:21:51 +0200
Subject: [PATCH v2 0/3] Pinctrl driver for Amlogic Meson SoCs
Message-ID: <1413321714-25931-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series introduces a driver for Amlogic Meson pinctrl and GPIOs,
adding the basic infrastructure for all the SoCs of the Meson family
and configuration data specific for Meson8.

I tested the pinmux and GPIO functionalities on a Tronsmart Vega S89e
TV box and everything seems to work, however I'm not so familiar with
the pinctrl subsystem and thus any feedback is very welcome.

Changes since v1 [https://lkml.org/lkml/2014/10/7/712]
 - added missing checks of return values
 - indentation fixes
 - added missing definitions of groups and functions for Meson8

Beniamino Galvani (3):
  pinctrl: add driver for Amlogic Meson SoCs
  pinctrl: meson: add device tree bindings documentation
  ARM: dts: meson8: add pinctrl and gpio nodes

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  79 ++
 arch/arm/boot/dts/meson8-vega-s89e.dts             |  16 +-
 arch/arm/boot/dts/meson8.dtsi                      |  35 +
 arch/arm/mach-meson/Kconfig                        |   3 +
 drivers/pinctrl/Kconfig                            |   8 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/meson/Makefile                     |   2 +
 drivers/pinctrl/meson/pinctrl-meson.c              | 824 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h              | 217 ++++++
 drivers/pinctrl/meson/pinctrl-meson8.c             | 534 +++++++++++++
 include/dt-bindings/gpio/meson8-gpio.h             | 155 ++++
 11 files changed, 1873 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
 create mode 100644 drivers/pinctrl/meson/Makefile
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8.c
 create mode 100644 include/dt-bindings/gpio/meson8-gpio.h

-- 
1.9.1
