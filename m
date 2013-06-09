From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  9 Jun 2013 18:36:01 +0200
Subject: [PATCH 0/6] Add support for Allwinner A10s SoCs
Message-ID: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patch serie reworks a bit the pinctrl driver and adds the necessary
bits needed to support the Allwinner A10s SoC.

This SoC is a bit in between the A10 and A13. Notable differences with
the A13 is the addition of an HDMI controller and of the EMAC.

For the time being (ie until we find a proper datasheet for this SoCs),
the clock definition is taken from the A10 one.

This patches depends on the "Add external interrupt support for Allwinner SoCs"
patch serie.

Thanks,
Maxime

Maxime Ripard (6):
  ARM: sunxi: Add Allwinner A10s machine compatible
  pinctrl: sunxi: Move the pins definitions to a separate header
  pinctrl: sunxi: Add Allwinner A10s pins
  ARM: sunxi: dt: Add Allwinner A10s DTSI
  ARM: sunxi: Add Olimex A10s-Olinuxino-micro device tree
  ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig

 Documentation/arm/sunxi/README                   |    4 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   75 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  286 +++
 arch/arm/configs/multi_v7_defconfig              |    2 +
 arch/arm/mach-sunxi/sunxi.c                      |    1 +
 drivers/pinctrl/pinctrl-sunxi-pins.h             | 2023 ++++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.c                  | 1362 +--------------
 7 files changed, 2393 insertions(+), 1360 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-sunxi-pins.h

-- 
1.8.3
