From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 Mar 2016 11:50:10 +0100
Subject: [PATCH 0/4] Add AXP209 GPIO driver
Message-ID: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The axp209 PMIC used in combination to some Allwinner SoCs has a bunch
of GPIOs accessible. Some boards use these to control their backlight
or a few LEDs.

There's supposed to be 4 of them, but the fourth one has a different
configuration register scheme, and I couldn't find any board that was
using this GPIO. It will be probably be supported eventually, but
until then, we support only the first 3 GPIOs.

Let me know what you think,
Maxime

Maxime Ripard (4):
  gpio: Add AXP209 GPIO driver
  mfd: axp20x: Add AXP209 GPIO driver to the mfd
  ARM: dt: axp209: Add AXP209 GPIO driver
  ARM: sun5i: chip: Add status LED

 .../devicetree/bindings/gpio/gpio-axp209.txt       |  30 ++++
 arch/arm/boot/dts/axp209.dtsi                      |   6 +
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  10 ++
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-axp209.c                         | 166 +++++++++++++++++++++
 drivers/mfd/axp20x.c                               |   3 +
 7 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
 create mode 100644 drivers/gpio/gpio-axp209.c

-- 
2.7.2
