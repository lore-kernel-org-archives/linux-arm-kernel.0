From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 12 Oct 2009 03:56:55 +0530
Subject: [PATCH v3 0/8] [ARM] ST-Ericsson's U8500 SMP platform, a new patch set
Message-ID: <1255300015.21542.404.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds a new machine support for ST-Ericsson's U8500 platform. This is
an entry level patch which has bindings to existing modules like GIC, SCU,
TWD, PL011 UART. This also adds a new SPI device AB4500 (odler name STW4500)
which uses ARM pl022 bus driver.

There are similarly numbered platforms will appear in the near future bearing
ux500 naming scheme, and hence this patch set has this name for the first
U8500 platform. This is v3 patch re-based to linux-2.6.32-rc3, and fixed most
of the review comments. For the patch 7/7 to work on hardware, get the 
patch 5741 from Russell's patch tracking system. 

srinidhi kasagar (7):
  [ARM]: U8500 register definitions
  [ARM]: U8500 clock framework
  [ARM]: U8500 core machine support
  [ARM]: U8500 Makefile.boot
  [ARM]: U8500 integrate to ARM architecture
  [ARM]: adds AB4500 as pl022 device
  mfd: add AB4500 SPI used in U8500

 arch/arm/Kconfig                                   |   19 ++-
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-ux500/Kconfig                        |   15 ++
 arch/arm/mach-ux500/Makefile                       |    8 +
 .../{mach-footbridge => mach-ux500}/Makefile.boot  |    0
 arch/arm/mach-ux500/board-mop500.c                 |  146 +++++++++++
 arch/arm/mach-ux500/clock.c                        |   95 +++++++
 arch/arm/mach-ux500/cpu-u8500.c                    |   78 ++++++
 arch/arm/mach-ux500/headsmp.S                      |   38 +++
 .../include/mach/clkdev.h                          |    0
 arch/arm/mach-ux500/include/mach/debug-macro.S     |   19 ++
 arch/arm/mach-ux500/include/mach/entry-macro.S     |   89 +++++++
 arch/arm/mach-ux500/include/mach/hardware.h        |  129 ++++++++++
 arch/arm/mach-ux500/include/mach/io.h              |   22 ++
 arch/arm/mach-ux500/include/mach/irqs.h            |   71 ++++++
 arch/arm/mach-ux500/include/mach/memory.h          |   18 ++
 arch/arm/mach-ux500/include/mach/mtu.h             |   53 ++++
 arch/arm/mach-ux500/include/mach/setup.h           |   22 ++
 arch/arm/mach-ux500/include/mach/smp.h             |   32 +++
 arch/arm/mach-ux500/include/mach/system.h          |   25 ++
 arch/arm/mach-ux500/include/mach/timex.h           |    6 +
 arch/arm/mach-ux500/include/mach/uncompress.h      |   58 +++++
 arch/arm/mach-ux500/include/mach/vmalloc.h         |   18 ++
 arch/arm/mach-ux500/localtimer.c                   |   28 ++
 arch/arm/mach-ux500/platsmp.c                      |  186 ++++++++++++++
 arch/arm/mach-ux500/timer.c                        |  163 ++++++++++++
 drivers/mfd/Kconfig                                |   10 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/ab4500-core.c                          |  207 +++++++++++++++
 include/linux/mfd/ab4500.h                         |  262 ++++++++++++++++++++
 30 files changed, 1815 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-ux500/Kconfig
 create mode 100644 arch/arm/mach-ux500/Makefile
 copy arch/arm/{mach-footbridge => mach-ux500}/Makefile.boot (100%)
 create mode 100644 arch/arm/mach-ux500/board-mop500.c
 create mode 100644 arch/arm/mach-ux500/clock.c
 create mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 create mode 100644 arch/arm/mach-ux500/headsmp.S
 copy arch/arm/{mach-bcmring => mach-ux500}/include/mach/clkdev.h (100%)
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
 create mode 100755 drivers/mfd/ab4500-core.c
 create mode 100644 include/linux/mfd/ab4500.h
