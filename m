From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:49 +0100
Subject: [PATCH 00/21] ARM: ux500: pin control device tree migration
Message-ID: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series migrated all the pin control information
for the Nomadik pin controller as used on the various Ux500
boards from the board file and into the device tree.

After this only the ABx500 pin configuration remains in the
board file. (Will be addressed separately.)

This uses the existing device tree bindings. No new bindings
are added.

Linus Walleij (21):
  ARM: ux500: move UART pin control to the device tree
  ARM: ux500: move I2C pin control to the device tree
  ARM: ux500: move MMC/SD/SDIO pin control to the device tree
  ARM: ux500: move MSP pin control to the device tree
  ARM: ux500: move GPIO217/218 config to device tree
  ARM: ux500: move MUSB pin config to device tree
  ARM: ux500: move SPI pin config to device tree
  ARM: ux500: create MCDE node to collect resources
  ARM: ux500: move MCDE pin config to device tree
  ARM: ux500: move SKE pin config to device tree
  ARM: ux500: drop STM pinmap settings
  ARM: ux500: move old HREF ipgpio to the device tree
  ARM: ux500: move GPIO key configuration to device tree
  ARM: ux500: move the WLAN GPIO pin setup to the device tree
  ARM: ux500: move the HREFv60plus IPGPIO pins to device tree
  ARM: ux500: move final HREFv60 LCD pins to device tree
  ARM: ux500: move HREFv60plus pin configs to device tree
  ARM: ux500: move snowball ethernet config to device tree
  ARM: ux500: convert Snowball SPI pin reference
  ARM: ux500: move snowball LED pin control to device tree
  ARM: ux500: move snowball pin configs to device tree

 arch/arm/boot/dts/ste-dbx5x0.dtsi              |  17 +
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 745 +++++++++++++++++++++++
 arch/arm/boot/dts/ste-href-stuib.dtsi          |  41 ++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi     |  51 ++
 arch/arm/boot/dts/ste-href.dtsi                |  78 ++-
 arch/arm/boot/dts/ste-hrefprev60.dtsi          |  65 ++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi         | 217 ++++++-
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi     |  80 +++
 arch/arm/boot/dts/ste-snowball.dts             | 225 +++++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 781 -------------------------
 10 files changed, 1503 insertions(+), 797 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi

-- 
1.8.3.1
