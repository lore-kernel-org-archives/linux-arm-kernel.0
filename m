From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Feb 2014 16:32:23 +0100
Subject: [PATCHv2 0/8] Device tree support for the at91sam9rlek
Message-ID: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT support for the at91sam9rl SoC, then the at91sam9rl-ek
evaluation board.

While the at91sam9rl dtsi should be almost complete (still missing LCD and
touchscreen bits). The at91sam9rlek DT now support the following tested
features:
 - MMC
 - dbgu
 - usart1
 - watchdog
 - nand
 - leds
 - buttons
 - common clock framework

Next:
 - spi
 - dataflash
 - i2c
 - lcd
 - touchscreen
 - usb gadget
 - audio

Changes since v1:
 - rebased on 3.14-rc3
 - improved dtsi compatible string
 - changed the kernel command line
 - reordered the dbgu description in the dtsi
 - added interrupts to the watchdog description (new in 3.14)
 - added CCF conversion

Alexandre Belloni (7):
  ARM: at91: Add at91sam9rl DT SoC support
  ARM: at91/defconfig: Add the sam9rl to the list of DT-enabled SOCs
  ARM: at91: dt: sam9rl: Device Tree for the at91sam9rlek
  ARM: at91: prepare common clk transition for sam9rl SoCs
  ARM: at91/dt: define at91sam9rl clocks
  ARM: at91/dt: define main clk frequency of at91sam9rlek
  ARM: at91: switch sam9rl to common clock framework

Boris BREZILLON (1):
  ARM: at91: prepare sam9 dt boards transition to common clk

 arch/arm/boot/dts/Makefile         |   2 +
 arch/arm/boot/dts/at91sam9rl.dtsi  | 855 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9rlek.dts | 157 +++++++
 arch/arm/configs/at91_dt_defconfig |   1 +
 arch/arm/mach-at91/Kconfig         |   1 -
 arch/arm/mach-at91/at91sam9rl.c    |  22 +-
 arch/arm/mach-at91/board-dt-sam9.c |  11 +-
 7 files changed, 1046 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9rl.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9rlek.dts

-- 
1.8.3.2
