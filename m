From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 24 Sep 2009 01:17:01 +0530
Subject: [PATCH 0/8] [ARM] ST-Ericsson's U8500 SMP platform, new patch set
Message-ID: <1253735221.21542.159.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds a new machine support for ST-Ericsson's U8500 platform. This is
an entry level patch which has bindings to existing modules like GIC, SCU,
TWD, PL011 UART. This also adds a new SPI device STw4500 which uses ARM pl022
bus driver. The patch is based on v2.6.31 kernel and tested on mop500 hardware
with SMP enabled.

This time I have split the patches for better readability. Also, for mfd 
device support, I have incorporated the review comments.

srinidhi kasagar (8):
  [ARM]: enable SMP support for U8500 architecture
  [ARM] U8500: adds secondary cpu support, local timers
  [ARM] U8500: adds mop500 platform
  [ARM] U8500: adds basic SoC support for U8500 CPU
  [ARM] U8500: adds basic clock framework
  [ARM] U8500: adds stw4500 as pl022 device
  mfd: add U8500 STw4500 SPI device support
  pl022: fix peripheral id for ST vendor

 arch/arm/Kconfig                                   |   20 ++-
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-ux500/Kconfig                        |   15 ++
 arch/arm/mach-ux500/Makefile                       |    8 +
 .../{mach-footbridge => mach-ux500}/Makefile.boot  |    0
 arch/arm/mach-ux500/board-mop500.c                 |  146 +++++++++++
 arch/arm/mach-ux500/clock.c                        |   95 +++++++
 arch/arm/mach-ux500/cpu-u8500.c                    |   78 ++++++
 arch/arm/mach-ux500/headsmp.S                      |   38 +++
 .../include/mach/clkdev.h                          |    0
 arch/arm/mach-ux500/include/mach/debug-macro.S     |   22 ++
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   80 ++++++
 arch/arm/mach-ux500/include/mach/hardware.h        |  129 ++++++++++
 arch/arm/mach-ux500/include/mach/io.h              |   22 ++
 arch/arm/mach-ux500/include/mach/irqs.h            |   71 ++++++
 arch/arm/mach-ux500/include/mach/memory.h          |   18 ++
 arch/arm/mach-ux500/include/mach/mtu.h             |   53 ++++
 arch/arm/mach-ux500/include/mach/setup.h           |   22 ++
 arch/arm/mach-ux500/include/mach/smp.h             |   29 +++
 arch/arm/mach-ux500/include/mach/system.h          |   25 ++
 arch/arm/mach-ux500/include/mach/timex.h           |    6 +
 arch/arm/mach-ux500/include/mach/uncompress.h      |   58 +++++
 arch/arm/mach-ux500/include/mach/vmalloc.h         |   18 ++
 arch/arm/mach-ux500/localtimer.c                   |   28 ++
 arch/arm/mach-ux500/platsmp.c                      |  181 ++++++++++++++
 arch/arm/mach-ux500/timer.c                        |  163 ++++++++++++
 drivers/mfd/Kconfig                                |   10 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/stw4500.c                              |  207 +++++++++++++++
 drivers/spi/amba-pl022.c                           |    2 +-
 include/linux/mfd/stw4500.h                        |  262 ++++++++++++++++++++
 31 files changed, 1803 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-ux500/Kconfig
 create mode 100644 arch/arm/mach-ux500/Makefile
 copy arch/arm/{mach-footbridge => mach-ux500}/Makefile.boot (100%)
 create mode 100644 arch/arm/mach-ux500/board-mop500.c
 create mode 100644 arch/arm/mach-ux500/clock.c
 create mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 create mode 100644 arch/arm/mach-ux500/headsmp.S
 copy arch/arm/{mach-ep93xx => mach-ux500}/include/mach/clkdev.h (100%)
 create mode 100644 arch/arm/mach-ux500/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-ux500/include/mach/hardware.h
 create mode 100644 arch/arm/mach-ux500/include/mach/io.h
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/memory.h
 create mode 100644 arch/arm/mach-ux500/include/mach/mtu.h
 create mode 100644 arch/arm/mach-ux500/include/mach/setup.h
 create mode 100644 arch/arm/mach-ux500/include/mach/smp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/system.h
 create mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 create mode 100644 arch/arm/mach-ux500/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-ux500/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-ux500/localtimer.c
 create mode 100644 arch/arm/mach-ux500/platsmp.c
 create mode 100644 arch/arm/mach-ux500/timer.c
 create mode 100755 drivers/mfd/stw4500.c
 create mode 100644 include/linux/mfd/stw4500.h
