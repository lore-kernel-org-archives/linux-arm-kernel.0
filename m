From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 11 Sep 2014 17:54:05 +0200
Subject: [PATCH 0/7] Initial support for the Atmel SMART sama5d4
Message-ID: <1410450852-1834-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for the Atmel SMART sama5d4.

Note that some drivers will complain that they can't work without DMA and the
probe will fail. This will be solved when the dma driver hits mainline, it is
still under review.

Alexandre Belloni (3):
  irqchip: atmel-aic5: Add sama5d4 support
  clk: at91: add a driver for the h32mx clock
  ARM: at91: add sama5d4 support to sama5_defconfig

Nicolas Ferre (4):
  ARM: at91: introduce basic SAMA5D4 support
  ARM: at91: SAMA5D4 SoC detection code and low level routines
  ARM: at91: dt: add device tree file for SAMA5D4 SoC
  ARM: at91: dt: add device tree file for SAMA5D4ek board

 .../devicetree/bindings/clock/at91-clock.txt       |   15 +
 arch/arm/Kconfig.debug                             |    4 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  308 +++++
 arch/arm/boot/dts/sama5d4.dtsi                     | 1233 ++++++++++++++++++++
 arch/arm/configs/sama5_defconfig                   |    2 +-
 arch/arm/mach-at91/Kconfig                         |   21 +
 arch/arm/mach-at91/Makefile                        |    1 +
 arch/arm/mach-at91/board-dt-sama5.c                |   35 +-
 arch/arm/mach-at91/generic.h                       |    5 +
 arch/arm/mach-at91/include/mach/cpu.h              |   22 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    5 +-
 arch/arm/mach-at91/include/mach/hardware.h         |   19 +-
 arch/arm/mach-at91/include/mach/sama5d4.h          |   35 +
 arch/arm/mach-at91/include/mach/uncompress.h       |   21 +-
 arch/arm/mach-at91/sama5d4.c                       |   64 +
 arch/arm/mach-at91/setup.c                         |   97 +-
 arch/arm/mach-at91/soc.h                           |    5 +
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-h32mx.c                       |  121 ++
 drivers/clk/at91/pmc.c                             |    6 +
 drivers/clk/at91/pmc.h                             |    5 +
 drivers/irqchip/irq-atmel-aic5.c                   |   10 +
 include/linux/clk/at91_pmc.h                       |    1 +
 24 files changed, 2025 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d4.dtsi
 create mode 100644 arch/arm/mach-at91/include/mach/sama5d4.h
 create mode 100644 arch/arm/mach-at91/sama5d4.c
 create mode 100644 drivers/clk/at91/clk-h32mx.c

-- 
1.9.1
