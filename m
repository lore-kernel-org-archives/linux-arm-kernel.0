From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  7 Sep 2016 16:53:56 +0200
Subject: [PATCH v2 0/4] Introduce NextThing GR8 support
Message-ID: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie introduces the support for the NextThing GR8.

This SoC is loosely based on the SoCs of the Allwinner sun5i family,
hence we can use most of the support already there. Compared to the
already existing A10s and A13/R8, the pin layout completely changed,
meaning that also the set of available controllers is changed.

There's some new controllers (SPDIF) and some are gone. This also
introduces the support for the GR8 Evaluation Board.

Even though it's not been tested yet, the SPDIF and I2S-related
components have been listed but we do not create a card from them, so
they won't be usable.

Let me know if you have any questions,
Maxime

Changes from v1:
  - Removed the panel part for now
  - Added a few missing gates
  - Changed the gate clocks compatible to the generic one
  - Switched to the OTG mode

Maxime Ripard (1):
  ARM: sunxi: Support the Nextthing GR8

Myl?ne Josserand (3):
  pinctrl: sunxi: Add GR8 controller support
  ARM: dts: Add NextThing GR8 dtsi
  ARM: dts: gr8: Add support for the GR8 evaluation board

 Documentation/arm/sunxi/README                     |    2 +
 Documentation/devicetree/bindings/arm/sunxi.txt    |    1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    1 +
 MAINTAINERS                                        |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/ntc-gr8-evb.dts                  |  342 +++++++
 arch/arm/boot/dts/ntc-gr8.dtsi                     | 1080 ++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c                        |    1 +
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-gr8.c                |  541 ++++++++++
 11 files changed, 1975 insertions(+)
 create mode 100644 arch/arm/boot/dts/ntc-gr8-evb.dts
 create mode 100644 arch/arm/boot/dts/ntc-gr8.dtsi
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-gr8.c

-- 
2.9.3
