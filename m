From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Tue, 22 Sep 2015 23:38:53 +0800
Subject: [PATCH 0/4] Add basic support for Allwinner A83T SOC
Message-ID: <1442936337-3104-1-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds very basic support for Allwinner A83T SOC.
Clock, peripherals, smp support will be added later.

Allwinner A83T is octa-core cortex-a7 based SoC.
It's clock control unit and prcm, pinmux are different from previous sun8i
series.
Its processor cores are arragned in two clusters 4 cores each,
similar to A80.

Patch1 This adds compatibe string for A83T
Patch2	adds PIO controller support R_PIO is yet to be added.
Patch3	adds basic dtsi
Patch4	Adds Alllwinner A83T Homletv2 board dts.

Vishnu Patekar (4):
  ARM: sunxi: Introduce Allwinner for A83T support
  pinctrl: sunxi: add allwinner A83T PIO controller support
  ARM: dts: sun8i: Add Allwinner A83T dtsi
  ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 .../boot/dts/sun8i-a83t-allwinner-homlet-v20.dts   |  69 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 243 +++++++++
 arch/arm/mach-sunxi/sunxi.c                        |   1 +
 drivers/clk/sunxi/clk-sunxi.c                      |   6 +
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c         | 603 +++++++++++++++++++++
 10 files changed, 932 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-allwinner-homlet-v20.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t.dtsi
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c

-- 
1.9.1
