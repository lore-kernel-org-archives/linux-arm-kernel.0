From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:37 +0200
Subject: [PATCH 0/6] Add support for NXP LPC18xx family
Message-ID: <1427923243-26296-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds minimal support for the LPC18xx/43xx family of
Cortex-M3/4 MCUs from NXP.

Patch set is based on Linus master v4.0-rc6. I assume it's too late
for 4.1 now, so the target for these patches is 4.2.

To keep the amount of dependencies down the PLL1 clock has been hard
coded in the lpc18xx.dtsi file. The clock system of LPC18xx is quite
advanced for a MCU and requires two clk drivers to work. A patch set
with these drivers and update to the dtsi files will be posted
separately.

Drivers for pinctrl, gpio, ethernet, i2c, rtc and emc (external
memories) are also coming for LPC18xx.  Right now these can found on:
https://github.com/manabian/linux-lpc

I don't know the policy on new kernel configs, but if this is a no go
the last patch can be dropped.

For zImage support: https://patchwork.kernel.org/patch/5505741/

Sucessfuly tested on Embedded Artist LPC4357 Developers Kit.

Joachim Eastwood (6):
  ARM: lpc18xx: add basic support for NXP LPC18xx/43xx SoCs
  clocksource: add lpc32xx timer driver
  doc: dt: add documentation for lpc3250-timer
  ARM: dts: Add base DT for NXP LPC18xx and LPC4357
  ARM: dts: Add DT for Embedded Artist LPC4357 Developers Kit
  ARM: lpc18xx: add kernel config

 .../bindings/timer/nxp,lpc3250-timer.txt           |  25 +++
 arch/arm/Kconfig                                   |  20 ++
 arch/arm/Kconfig.debug                             |   8 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/lpc18xx.dtsi                     | 117 ++++++++++
 arch/arm/boot/dts/lpc4357-ea4357.dts               |  34 +++
 arch/arm/boot/dts/lpc4357.dtsi                     |  39 ++++
 arch/arm/configs/lpc18xx_defconfig                 | 135 +++++++++++
 arch/arm/mach-lpc18xx/Makefile                     |   1 +
 arch/arm/mach-lpc18xx/Makefile.boot                |   3 +
 arch/arm/mach-lpc18xx/board-dt.c                   |  24 ++
 drivers/clocksource/Kconfig                        |  10 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/time-lpc32xx.c                 | 249 +++++++++++++++++++++
 15 files changed, 666 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3250-timer.txt
 create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4357-ea4357.dts
 create mode 100644 arch/arm/boot/dts/lpc4357.dtsi
 create mode 100644 arch/arm/configs/lpc18xx_defconfig
 create mode 100644 arch/arm/mach-lpc18xx/Makefile
 create mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 create mode 100644 arch/arm/mach-lpc18xx/board-dt.c
 create mode 100644 drivers/clocksource/time-lpc32xx.c

-- 
1.8.0
