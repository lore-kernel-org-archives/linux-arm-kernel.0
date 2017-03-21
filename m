From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 19:28:29 +0100
Subject: [PATCH v2 0/7] Hi,
Message-ID: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this series add support for the pin and gpio controllers present on
the Armada 37xx SoCs.

Each Armada 37xx SoC comes with 2 pin controllers: one on the south
bridge (managing 28 pins) and one on the north bridge (managing 36 pins).

At the hardware level the controller configure the pins by group and not
pin by pin.

The gpio controller is also capable to handle interrupt from gpio.

Gregory

Gregory CLEMENT (7):
  pinctrl: dt-bindings: Add documentation for Armada 37xx pin controllers
  arm64: marvell: enable the Armada 37xx pinctrl driver
  pinctrl: armada-37xx: Add pin controller support for Armada 37xx
  pinctrl: armada-37xx: Add gpio support
  pinctrl: aramda-37xx: Add irqchip support
  ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
  ARM64: dts: marvell: armada37xx: add pinctrl definition

 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt         |   7 +-
 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt | 143 +++++++++++-
 arch/arm64/Kconfig.platforms                                              |   2 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                            |   8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                              |  71 +++++-
 drivers/pinctrl/Makefile                                                  |   2 +-
 drivers/pinctrl/mvebu/Kconfig                                             |   7 +-
 drivers/pinctrl/mvebu/Makefile                                            |   3 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                               | 918 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 1153 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c

base-commit: c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201
-- 
git-series 0.9.1
