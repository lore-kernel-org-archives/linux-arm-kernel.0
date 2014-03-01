From: carlo@caione.org (Carlo Caione)
Date: Sat,  1 Mar 2014 17:45:45 +0100
Subject: [PATCH 0/7] mfd: AXP20x: Add support for AXP202 and AXP209
Message-ID: <1393692352-10839-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
as well as 4 configurable GPIOs. 

This set of patches introduces the core driver and support for two different
subsystems:
	- Regulators
	- PEK (Power Enable Key)

Support for AXP209 in Cubieboard2 is also added.

Carlo Caione (7):
  mfd: AXP20x: Add mfd driver for AXP20x PMIC
  mfd: AXP20x: Add bindings documentation
  ARM: dts: cubieboard2: Add AXP209 support
  input: misc: Add driver for AXP20x Power Enable Key
  input: misc: Add ABI docs for AXP20x PEK
  regulator: AXP20x: Add support for regulators subsystem
  ARM: dts: Cubieboard2: Add support for AXP209 regulators

 .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 ++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  58 ++++
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/axp20x-pek.c                    | 265 ++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/axp20x.c                               | 250 +++++++++++++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/axp20x-regulator.c               | 349 +++++++++++++++++++++
 include/linux/mfd/axp20x.h                         | 180 +++++++++++
 14 files changed, 1243 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 drivers/regulator/axp20x-regulator.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.3.2
