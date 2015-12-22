From: ilya@compulab.co.il (Ilya Ledvich)
Date: Tue, 22 Dec 2015 10:15:18 +0200
Subject: [PATCH v2 0/2] Add support for CL-SOM-iMX7 and SBC-iMX7
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1450772120-18131-1-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for CompuLab CL-SOM-iMX7 and
SBC-iMX7 boards.

CL-SOM-iMX7 is a miniature System-on-Module (SoM) based on
Freescale i.MX7 ARM Cortex-A7 System-on-Chip.
s
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

Changes history:
v2: use generic node name for pmic (Thanks Rob)
    move board description out of fsl.txt (Shawn)
    use GPL/X11 dual licence for newly added dts files (Shawn)
    discard one level of container node (Shawn)
    squash several patches into one patch (Shawn)

Ilya Ledvich (2):
  ARM: dts: imx7d: cl-som-imx7: add basic module support
  ARM: dts: imx7d: sbc-imx7: add basic board support

 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 293 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  44 +++++
 3 files changed, 339 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-cl-som-imx7.dts
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-imx7.dts

-- 
1.9.1
