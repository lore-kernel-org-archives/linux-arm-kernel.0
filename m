From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 17 Jan 2015 19:15:13 +0100
Subject: [PATCH v4 0/3] Amlogic Meson pinctrl driver
Message-ID: <1421518516-26976-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds a pinctrl driver for Amlogic Meson, providing common
code for all the SoCs of the family and configuration data specific
for Meson8.

DT binding documentation for the driver has already been merged and is
not included in the series. The first patch is for the pinctrl/devel
tree, the others for Carlo's meson tree.

Thanks,
Beniamino

Changes since v3 [ https://lkml.org/lkml/2014/11/16/171 ]
 - add 'static' to meson8 structs and arrays
 - use ERR_CAST() to avoid sparse warning in meson_map_resource()
 - declare group list as 'const char * const *'

Changes since v2 [ https://lkml.org/lkml/2014/10/14/423 ]
 - move modifications to mach-meson Kconfig to a separate patch
 - use regmap_mmio
 - use generic gpio xlate function
 - don't hardcode gpio base number
 - use gpiochip_add_pin_range()
 - add kerneldoc documentation
 - use plain module_platform_driver() instead of postcore_initcall
 - avoid unneeded copies of platform data

Changes since v1 [ https://lkml.org/lkml/2014/10/7/712 ]
 - added missing checks of return values
 - indentation fixes
 - added missing definitions of groups and functions for Meson8

Beniamino Galvani (3):
  pinctrl: add driver for Amlogic Meson SoCs
  ARM: meson: select PINCTRL_MESON and ARCH_REQUIRE_GPIOLIB
  ARM: dts: meson8: add pinctrl node

 arch/arm/boot/dts/meson8.dtsi          |   68 ++
 arch/arm/mach-meson/Kconfig            |    3 +
 drivers/pinctrl/Kconfig                |    8 +
 drivers/pinctrl/Makefile               |    1 +
 drivers/pinctrl/meson/Makefile         |    2 +
 drivers/pinctrl/meson/pinctrl-meson.c  |  761 ++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h  |  209 ++++++
 drivers/pinctrl/meson/pinctrl-meson8.c | 1089 ++++++++++++++++++++++++++++++++
 include/dt-bindings/gpio/meson8-gpio.h |  157 +++++
 9 files changed, 2298 insertions(+)
 create mode 100644 drivers/pinctrl/meson/Makefile
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8.c
 create mode 100644 include/dt-bindings/gpio/meson8-gpio.h

-- 
2.1.4
