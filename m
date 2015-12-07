From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:31 +0200
Subject: [PATCH 0/8] Add support for CL-SOM-iMX7 and SBC-iMX7
Message-ID: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for CompuLab CL-SOM-iMX7 and
SBC-iMX7 boards.

CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
Freescale i.MX7 ARM Cortex-A7 System-on-Chip.

SBC-iMX7 is a single board computer, implemented with the
CL-SOM-iMX7 System-on-Module providing most of the functions,
and SB-SOM-iMX7 carrier board providing additional peripheral
functions and connectors.

The SBC-iMX7 provides following features:

CPU:		Freescale i.MX 7Dual ARM Cortex-A7, 1GHz NEON SIMD and VFPv4 or
		Freescale i.MX 7Solo ARM Cortex-A7, 800MHz NEON SIMD and VFPv4

RAM:		DDR3, 256MB - 2GB

Storage:	NAND flash, 128MB - 1GB or eMMC flash, 4GB - 32GB
		SPI flash, 2MB
		Standard full-size SD socket

Ethernet:	Up to 2x 10/100/1000Mbps Ethernet ports (MAC+PHY)

WiFi/BT:	Dual-band 2x2 802.11a/b/g/n WiFi interface (TI WiLink 8 WL1837 chipset)

Analog Audio:	Audio codec with analog stereo output, stereo input and microphone support

More details can be found here:

http://www.compulab.co.il/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/

http://www.compulab.co.il/products/sbcs/sbc-imx7-freescale-i-mx-7-single-board-computer/

This series provides basic DT support including following features:

* Memory configuration
* eMMC
* 2x Gigabit Ethernet ports (FEC1 and FEC2)
* I2C2 bus
  * EEPROM
  * PCA9555 GPIO extender
  * PMIC
* UART1
* USB OTG port

Ilya Ledvich (8):
  ARM: dts: imx7d: cl-som-imx7: add basic module support
  ARM: dts: imx7d: cl-som-imx7: add usb otg support
  ARM: dts: imx7d: cl-som-imx7: add eMMC support
  ARM: dts: imx7d: cl-som-imx7: add fec1 support
  ARM: dts: imx7d: cl-som-imx7: add eeprom support
  ARM: dts: imx7d: cl-som-imx7: add gpio extender support
  ARM: dts: imx7d: cl-som-imx7: add fec2 support
  ARM: dts: imx7d: sbc-imx7: add basic board support

 Documentation/devicetree/bindings/arm/fsl.txt |   8 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts       | 294 ++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts          |  43 ++++
 4 files changed, 347 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-cl-som-imx7.dts
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-imx7.dts

-- 
1.9.1
