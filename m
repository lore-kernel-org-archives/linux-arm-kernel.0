From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed,  9 Apr 2014 15:51:03 +0200
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
Message-ID: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series rework the sunxi pinctrl driver to support the PLx pins
available on the A31 SoC.

It also add missing A31 reset controller DT bindings documentation.

I need those PL pins (actually I only need PL0 and PL1) to support
the P2WI bus, which in turn is used to communicate with the AXP221
PMIC.

Let me know if these changes are too intrusive.

Best Regards,

Boris

Boris BREZILLON (15):
  ARM: sunxi: dt: list all pinctrl compatible strings
  ARM: sunxi: dt: document pinctrl clock related properties
  ARM: sunxi: dt: add pinctrl clock-names properties
  pinctrl: sunxi: specify clk name when retrieving pinctrl pio clk
  clk: sunxi: add A31 APB0 clk gate defintions
  clk: sunxi: add A31 APB0 gates compatible string to the documentation
  ARM: sunxi: dt: define A31's APB0 clk gates node
  reset: sunxi: document sunxi's reset controllers bindings
  clk: sunxi: add A31 APB0 reset line defintions
  pinctrl: sunxi: add PL pin definitions
  pinctrl: sunxi: add support for A31 PL pins
  pinctrl: sunxi: retrieve and enable PL clk gate for A31 SoC
  pinctrl: sunxi: retrieve and enable PL reset line for A31 SoC
  pinctrl: sunxi: define A31 PL0/PL1 pins
  ARM: sunxi: dt: add support for A31's PL pins

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |  13 +-
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |  21 +++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   1 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   1 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   1 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  25 ++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   1 +
 drivers/clk/sunxi/clk-sunxi.c                      |   5 +
 drivers/pinctrl/pinctrl-sunxi-pins.h               |   8 +
 drivers/pinctrl/pinctrl-sunxi.c                    | 205 +++++++++++++++------
 drivers/pinctrl/pinctrl-sunxi.h                    |  39 +++-
 12 files changed, 264 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt

-- 
1.8.3.2
