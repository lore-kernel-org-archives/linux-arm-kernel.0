From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:01 +0200
Subject: [PATCH 00/14] Add support for sbc-t43
Message-ID: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for CompuLab sbc-t43 single baseboard computer.
sbc-t43 is composed of cm-t43 (the TI am437x based core module), and sb-som
baseboard. The sbc-t43 features include:

CPU:	Texas Instruments Sitara AM4379 ARM Cortex-A9, 1GHz, or
	Texas Instruments Sitara AM4376 ARM Cortex-A9, 800MHz
RAM:	128MB - 1GB, DDR3-800, 32-bit data bua
Storage:	NAND flash, 128MB - 512MB, or eMMC flash, 4GB - 32GB
		SPI-flash 2MB
Two 1000/100/10Mbps Ethernet ports
WiFi/Bluetooth/NFC
Audio codec
SD-Card slot, up to 3 USB ports
DVI/LCD connectors

This series is based over v4.4-rc2-15-gcaa9c04 and depends on the following
patch:
https://lkml.org/lkml/2015/11/12/955
[pinctrl: Move am4372 and dra7 macros to the the SoC header files]

Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>

Nikita Kiryanov (14):
  ARM: am437x: cm-t43: dts: add basic support for sbc-t43
  ARM: am437x: cm-t43: dts: add support for module eeprom
  ARM: am437x: cm-t43: dts: add PMIC support.
  ARM: am437x: cm-t43: dts: add spi-flash support
  ARM: am437x: cm-t43: dts: add NAND support
  ARM: am437x: cm-t43: dts: add dual emac support
  ARM: am437x: cm-t43: dts: add USB support
  ARM: am437x: cm-t43: dts: add eMMC support
  ARM: am437x: cm-t43: dts: add touchscreen support
  ARM: am437x: cm-t43: dts: add pca9555 support
  ARM: am437x: cm-t43: dts: add support for baseboard eeprom
  ARM: sb-som: dts: introduce SB-SOM baseboard
  ARM: am437x: cm-t43: dts: add support for mmc1
  ARM: am437x: cm-t43: dts: add lcd support

 .../devicetree/bindings/arm/compulab-boards.txt    |   5 +
 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 .../bindings/display/panel/startek,startek-kd050c  |   4 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                | 423 +++++++++++++++++++++
 arch/arm/boot/dts/am437x-sbc-t43.dts               | 181 +++++++++
 arch/arm/boot/dts/compulab-sb-som.dtsi             |  42 ++
 8 files changed, 666 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi

-- 
1.9.1
