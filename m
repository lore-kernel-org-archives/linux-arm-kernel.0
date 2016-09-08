From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Sep 2016 12:26:07 +0200
Subject: [PATCH v3 0/4] Introduce NextThing GR8 support
Message-ID: <20160908102610.26783-1-maxime.ripard@free-electrons.com>
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

Changes from v2:
  - Moved the GR8 DTSI changes to the right patch
  - Fixed a typo in the hstimer clock
  - Fixed the emac bus clock name
  - Changed the PLL3 compatible clocks
  - Split the i2s pinctrl nodes
  - Used the pinctrl macros for the NAND pinctrl nodes

Changes from v1:
  - Removed the panel part for now
  - Added a few missing gates
  - Changed the gate clocks compatible to the generic one
  - Switched to the OTG mode

Maxime Ripard (1):
  ARM: sunxi: Support the Nextthing GR8

Myl?ne Josserand (2):
  ARM: dts: Add NextThing GR8 dtsi
  ARM: dts: gr8: Add support for the GR8 evaluation board

 Documentation/arm/sunxi/README                  |    2 +
 Documentation/devicetree/bindings/arm/sunxi.txt |    1 +
 MAINTAINERS                                     |    1 +
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/ntc-gr8-evb.dts               |  342 +++++++
 arch/arm/boot/dts/ntc-gr8.dtsi                  | 1087 +++++++++++++++++++++++
 arch/arm/mach-sunxi/sunxi.c                     |    1 +
 7 files changed, 1435 insertions(+)
 create mode 100644 arch/arm/boot/dts/ntc-gr8-evb.dts
 create mode 100644 arch/arm/boot/dts/ntc-gr8.dtsi

-- 
2.9.3
