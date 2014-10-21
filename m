From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 09:14:22 +0200
Subject: [PATCH v7 00/10] initial suport for Alphascale ASM9260
Message-ID: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provide initial support for Alpascale ASM9260,
ARM based SoC.

Oleksij Rempel (10):
  ARM: add mach-asm9260
  ARM: add lolevel debug support for asm9260
  ARM: clk: add clk-asm9260 driver
  ARM: irqchip: mxs: prepare driver for HW with different offsets
  ARM: irqchip: mxs: add Alpascale ASM9260 support
  ARM: clocksource: add asm9260_timer driver
  ARM: tty: mxs-auart: add initial Alphascale ASM9260 support
  ARM: dts: add DT for Alphascale ASM9260 SoC
  ARM: add alphascale,acc.txt bindings documentation
  add Alphascale to vendor-prefixes.txt

 .../devicetree/bindings/clock/alphascale,acc.txt   | 115 +++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  33 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  21 ++
 arch/arm/boot/dts/alphascale-asm9260.dtsi          | 134 ++++++++
 arch/arm/include/debug/asm9260.S                   |  31 ++
 arch/arm/mach-asm9260/Kconfig                      |   8 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-asm9260.c                          | 351 +++++++++++++++++++
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/asm9260_timer.c                | 220 ++++++++++++
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/alphascale_asm9260-icoll.h         | 109 ++++++
 drivers/irqchip/irq-mxs.c                          | 157 ++++++++-
 drivers/tty/serial/Kconfig                         |   5 +-
 drivers/tty/serial/alphascale,asm9260_serial.h     | 373 +++++++++++++++++++++
 drivers/tty/serial/mxs-auart.c                     | 344 ++++++++++++-------
 include/dt-bindings/clock/alphascale,asm9260.h     |  97 ++++++
 22 files changed, 1873 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig
 create mode 100644 drivers/clk/clk-asm9260.c
 create mode 100644 drivers/clocksource/asm9260_timer.c
 create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h
 create mode 100644 drivers/tty/serial/alphascale,asm9260_serial.h
 create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h

-- 
1.9.1
