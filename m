From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Dec 2016 18:24:55 +0100
Subject: [PATCH 0/6] Add support for pinctrl/gpio on Armada 37xx
Message-ID: <20161222172501.16121-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series add support for the pin and gpio controllers present on
the Armada 37xx SoCs.

Each Armada 37xx SoC comes with 2 pin controllers: one on the south
bridge (managing 28 pins) and one on the north bridge (managing 36 pins).

At the hardware level the controller configure the pins by group and not
pin by pin.

The gpio controller is also capable to handle interrupt from gpio.

Gregory

Gregory CLEMENT (6):
  pinctrl: dt-bindings: Add documentation for Armada 37xx pin
    controllers
  pinctrl: armada-37xx: Add pin controller support for Armada 37xx
  pinctrl: armada-37xx: Add gpio support
  pinctrl: aramda-37xx: Add irqchip support
  ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
  ARM64: dts: marvell: armada37xx: add pinctrl definition

 .../pinctrl/marvell,armada-37xx-pinctrl.txt        | 127 +++
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   8 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  60 +-
 drivers/pinctrl/Makefile                           |   2 +-
 drivers/pinctrl/mvebu/Kconfig                      |   7 +
 drivers/pinctrl/mvebu/Makefile                     |   3 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        | 848 +++++++++++++++++++++
 8 files changed, 1052 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c

-- 
2.11.0
