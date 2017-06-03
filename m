From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  3 Jun 2017 22:44:24 +0800
Subject: [PATCH 0/3] pinctrl: sun8i: Add support for A83T R_PIO
Message-ID: <20170603144427.22855-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for the R_PIO pin controller on the A83T.
The pins managed this controller are mainly used for communicating
with the PMIC and codec, and various GPIOs for enabling power switches
for USB ports and WiFi.

Patch 1 updates the sunxi pinctrl bindings.

Patch 2 adds the pinctrl driver.

Patch 3 adds a device node for the pin controller.

Please have a look.

Regards
ChenYu


Chen-Yu Tsai (3):
  dt-bindings: pinctrl: sunxi: Add compatible string for A83T R_PIO
  pinctrl: sunxi: Add support for A83T R_PIO
  ARM: sun8i: a83t: Add device node for R_PIO

 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  15 +++
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c       | 128 +++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c

-- 
2.11.0
