From: marek@goldelico.com (Marek Belisko)
Date: Thu, 12 Feb 2015 14:03:42 +0100
Subject: [PATCH 0/4] add openpandora device support
Message-ID: <1423746226-700-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds initial device tree support for the
OpenPandora. The most important parts are working (display, keyboard,
touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.

First patch add common dtsi file which is then used in 600mhz and 1ghz
variants of openpandora which support is added in patches 2 and 3.

H. Nikolaus Schaller (4):
  ARM: dts: omap3-pandora: add common device tree
  ARM: dts: omap3-pandora: add OMAP3530 600 MHz version
  ARM: dts: omap3-pandora: add DM3730 1 GHz version
  ARM: dts: omap3-pandora: include in dts Makefile

 arch/arm/boot/dts/Makefile                  |   2 +
 arch/arm/boot/dts/omap3-pandora-1ghz.dts    |  65 +++
 arch/arm/boot/dts/omap3-pandora-600mhz.dts  |  65 +++
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 641 ++++++++++++++++++++++++++++
 4 files changed, 773 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-600mhz.dts
 create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi

-- 
1.9.1
