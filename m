From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 Sep 2014 18:15:52 +0200
Subject: [PATCHv3 0/7] Initial support for the Atmel SMART sama5d4
Message-ID: <1410797759-18675-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for the Atmel SMART sama5d4.

Note that some drivers will complain that they can't work without DMA and the
probe will fail. This will be solved when the dma driver hits mainline, it is
still under review.

changes in v3:
 - removed aic patch, already taken by jason
 - reworked documentation and h32mx clk driver like suggested by Nicolas
 - reordered nodes in the dtsi

Alexandre Belloni (3):
  clk: at91: add a driver for the h32mx clock
  ARM: at91: add sama5d4 support to sama5_defconfig
  ARM: at91: document Atmel SMART compatibles

Nicolas Ferre (4):
  ARM: at91: introduce basic SAMA5D4 support
  ARM: at91: SAMA5D4 SoC detection code and low level routines
  ARM: at91: dt: add device tree file for SAMA5D4 SoC
  ARM: at91: dt: add device tree file for SAMA5D4ek board

 .../devicetree/bindings/arm/atmel-at91.txt         |   37 +
 .../devicetree/bindings/clock/at91-clock.txt       |   15 +
 arch/arm/Kconfig.debug                             |    4 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  308 +++++
 arch/arm/boot/dts/sama5d4.dtsi                     | 1239 ++++++++++++++++++++
 arch/arm/configs/sama5_defconfig                   |    1 +
 arch/arm/mach-at91/Kconfig                         |   21 +
 arch/arm/mach-at91/Makefile                        |    1 +
 arch/arm/mach-at91/board-dt-sama5.c                |   17 +-
 arch/arm/mach-at91/generic.h                       |    1 +
 arch/arm/mach-at91/include/mach/cpu.h              |   22 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    5 +-
 arch/arm/mach-at91/include/mach/hardware.h         |   19 +-
 arch/arm/mach-at91/include/mach/sama5d4.h          |   33 +
 arch/arm/mach-at91/include/mach/uncompress.h       |   21 +-
 arch/arm/mach-at91/sama5d4.c                       |   64 +
 arch/arm/mach-at91/setup.c                         |   97 +-
 arch/arm/mach-at91/soc.h                           |    5 +
 drivers/clk/at91/Makefile                          |    1 +
 drivers/clk/at91/clk-h32mx.c                       |  123 ++
 drivers/clk/at91/pmc.c                             |    6 +
 drivers/clk/at91/pmc.h                             |    5 +
 include/linux/clk/at91_pmc.h                       |    1 +
 24 files changed, 2036 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4ek.dts
 create mode 100644 arch/arm/boot/dts/sama5d4.dtsi
 create mode 100644 arch/arm/mach-at91/include/mach/sama5d4.h
 create mode 100644 arch/arm/mach-at91/sama5d4.c
 create mode 100644 drivers/clk/at91/clk-h32mx.c

-- 
1.9.1
