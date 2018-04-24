From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 24 Apr 2018 17:55:01 +0200
Subject: [PATCH v5 0/2] Add Nintendo NES/SuperNES classic support
Message-ID: <20180424155503.19518-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the NES/SuperNES classic consoles from
Nintendo. Changes are done in A23/A33 DTSI to add NAND support.

Thanks,
Miqu?l

Changes since v4
================
* I should not have added cs1 and rb1 pins in the default pinctrl,
  removed.

Changes since v3
================
* Moved the pinctrl declaration in the first patch.
* Fixed the "nintendo,super-nes-classic" compatible name.
* Added the "nintendo,nes-classic" compatible in the
  nintendo-super-nes-classic DT.
* Removed repeated aliases/chosen nodes from
  nintendo-super-nes-classic DT.

Changes since v2
================
* s/arm:/ARM:/ in commit title.
* Added "Allwinner,sun8i-r16" compatibles.
* Removed USB host controller nodes.
* Added dr_mode = "otg" to OTG node.
* Added the bias-pull-up property to CS/RB pins.
* Renamed 'sun8i-r16-nintendo-supernes-classic.dts' into
  'sun8i-r16-nintendo-super-nes-classic.dts'.
* Added copyright licenses.

Changes since v1
================

arm: dts: sun8i: a23/a33: declare NAND pins
 * Patch created by splitting the v1 in two
 * Removed the trailing '@0' after the NAND pins declarations
 * Changed the name of these declarations
 * Declared all CS/RB lines
 * Reorganized the pins entry of nand_pins

arm: dts: nes: add Nintendo NES/SuperNES Classic Edition support
 * Created two DTS: nes-classic and supernes-classic
 * Moved the NAND pinctrl declaration into the DTSI
 * Removed the USB hackery explanation
 * Explained why one UART port is preferred to the other


Miquel Raynal (2):
  ARM: dts: sun8i: a23/a33: declare NAND pins
  ARM: dts: nes: add Nintendo NES/SuperNES Classic Edition support

 arch/arm/boot/dts/Makefile                         |  2 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 33 +++++++++++++
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    | 56 ++++++++++++++++++++++
 .../dts/sun8i-r16-nintendo-super-nes-classic.dts   | 11 +++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts

-- 
2.14.1
