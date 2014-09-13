From: linux@rempel-privat.de (Oleksij Rempel)
Date: Sun, 14 Sep 2014 00:13:21 +0200
Subject: [PATCH 0/7] initial suport for Alpscale ASM9260
Message-ID: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset provide initial support for Alpscale ASM9260,
ARM based SoC.

Oleksij Rempel (7):
  ARM: add mach-asm9260
  add include/debug/asm9260.S
  ARM: dts: add DT for Alpscale ASM9260 SoC
  clk: add clk-asm9260 driver
  clocksource: add asm9260_timer driver
  irqchip: add irq-asm9260 driver
  tty/serial: add asm9260-serial driver

 arch/arm/Kconfig                     |   16 +
 arch/arm/Kconfig.debug               |   33 +-
 arch/arm/Makefile                    |    1 +
 arch/arm/boot/dts/Makefile           |    2 +
 arch/arm/boot/dts/asm9260-devkit.dts |   15 +
 arch/arm/boot/dts/asm9260.dtsi       |  425 ++++++++++++
 arch/arm/include/debug/asm9260.S     |   31 +
 arch/arm/mach-asm9260/Kconfig        |   66 ++
 arch/arm/mach-asm9260/Makefile       |   11 +
 arch/arm/mach-asm9260/Makefile.boot  |    2 +
 arch/arm/mach-asm9260/core.c         |   77 +++
 drivers/clk/Makefile                 |    1 +
 drivers/clk/clk-asm9260.c            |  159 +++++
 drivers/clocksource/Makefile         |    1 +
 drivers/clocksource/asm9260_timer.c  |  232 +++++++
 drivers/irqchip/Makefile             |    1 +
 drivers/irqchip/irq-asm9260.c        |  237 +++++++
 drivers/tty/serial/Kconfig           |   19 +
 drivers/tty/serial/Makefile          |    1 +
 drivers/tty/serial/asm9260_serial.c  | 1236 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h     |    2 +
 21 files changed, 2565 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/asm9260.dtsi
 create mode 100644 arch/arm/include/debug/asm9260.S
 create mode 100644 arch/arm/mach-asm9260/Kconfig
 create mode 100644 arch/arm/mach-asm9260/Makefile
 create mode 100644 arch/arm/mach-asm9260/Makefile.boot
 create mode 100644 arch/arm/mach-asm9260/core.c
 create mode 100644 drivers/clk/clk-asm9260.c
 create mode 100644 drivers/clocksource/asm9260_timer.c
 create mode 100644 drivers/irqchip/irq-asm9260.c
 create mode 100644 drivers/tty/serial/asm9260_serial.c

-- 
1.9.1
