From: fkan@apm.com (Feng Kan)
Date: Thu, 31 Jul 2014 12:03:24 -0700
Subject: [PATCH V6 0/3] gpio: Add APM X-Gene SoC platform GPIO driver
Message-ID: <1406833407-28316-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the GPIO controller in the APM X-Gene platform. The GPIO
controller pins are muxed with the generic flash controller pins on the 
system.

V6 Change:
	1. change attribute description of second cell in gpio dts node
	   under documentation.

V5 Change:
	1. Remove gpio->dev
	2. Remove not needed headers. 
	3. Change to use latest driver.h for gpio.
	4. Set chip base to -1
	5. Put back label as it is needed sys interface.

V4 Change:
	1. Add remove function for module
	2. Add set function to dir out function.
	3. remove sets to np and label in probe.

V3 Change:
	1. Change code to use single entry to describe gpio node, hardcode
	   to use bank stride to target gpios.
	2. Fix up dts and doc accordingly

V2 Change:
	1. Address concerns from maintainer, split to multiple device node
	2. Add pm code to restore set register.
	3. fix up dts and documentation accordingly.

Feng Kan (3):
  gpio: Add APM X-Gene SoC GPIO controller support
  Documentation: gpio: Add APM X-Gene SoC GPIO controller DTS binding
  arm64:dts: Add APM X-Gene SoC GPIO controller DTS entries

 .../devicetree/bindings/gpio/gpio-xgene.txt        |  22 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |   7 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-xgene.c                          | 250 +++++++++++++++++++++
 5 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene.txt
 create mode 100644 drivers/gpio/gpio-xgene.c

-- 
1.9.1
