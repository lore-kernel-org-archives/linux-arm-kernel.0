From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 12:40:11 +0200
Subject: [PATCH v8 0/9] initial suport for Alphascale ASM9260
Message-ID: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provide initial support for Alpascale ASM9260,
ARM based SoC.
Changes since laste version:
- make sure all driver use of_io_request_and_map
- check alignment in Kconfig or Makefile where possible
- remove UART driver from this patchset to make review easier.

Oleksij Rempel (9):
  ARM: add mach-asm9260
  ARM: add lolevel debug support for asm9260
  ARM: clk: add clk-asm9260 driver
  ARM: irqchip: mxs: prepare driver for HW with different offsets
  ARM: irqchip: mxs: add Alpascale ASM9260 support
  ARM: clocksource: add asm9260_timer driver
  ARM: dts: add DT for Alphascale ASM9260 SoC
  ARM: add alphascale,acc.txt bindings documentation
  add Alphascale to vendor-prefixes.txt

 .../devicetree/bindings/clock/alphascale,acc.txt   | 115 +++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  33 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  13 +
 arch/arm/boot/dts/alphascale-asm9260.dtsi          |  63 ++++
 arch/arm/include/debug/asm9260.S                   |  31 ++
 arch/arm/mach-asm9260/Kconfig                      |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-asm9260.c                          | 345 +++++++++++++++++++++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/asm9260_timer.c                | 220 +++++++++++++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/alphascale_asm9260-icoll.h         | 109 +++++++
 drivers/irqchip/irq-mxs.c                          | 150 ++++++++-
 include/dt-bindings/clock/alphascale,asm9260.h     |  97 ++++++
 19 files changed, 1189 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig
 create mode 100644 drivers/clk/clk-asm9260.c
 create mode 100644 drivers/clocksource/asm9260_timer.c
 create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h
 create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h

-- 
1.9.1
