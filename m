From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:13 +0100
Subject: [PATCH 00/10] ARM: realview multiplatform
Message-ID: <1448469143-447355-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've posted this series before and this time just want to get the
ball rolling again. Linus Walleij has a series to convert realview
to use devicetree, and that is likely to conflict with this one,
so we should try to get the two things merged together properly.

Also, Russell has in the past had some concerns about the CPU
selection changes, and I'm not sure if the current version addresses
them all.

It would be nice to get as much as possible of this series into
the next/multiplatform branch for 4.5, hopefully getting to the
point where we can use it in a multiplatform configuration.

Arnd Bergmann (10):
  ARM: realview: remove sparsemem hack
  ARM: realview: don't map undefined PCI registers
  clk/realview: stop using machine headers
  ARM: no longer force unbuffered DMA for realview
  ARM: realview: remove private barrier implementation
  ARM: realview: enable multiplatform
  ARM: integrator: use explicit core module options
  ARM: no longer make CPU targets visible separately
  ARM: realview: make all header files local
  ARM: realview: clean up header files

 arch/arm/Kconfig                                   |  16 ---
 arch/arm/mach-integrator/Kconfig                   | 132 ++++++++++++++++++---
 arch/arm/mach-realview/Kconfig                     |  62 +++++++---
 arch/arm/mach-realview/Makefile                    |   7 +-
 .../mach-realview/{include/mach => }/board-eb.h    |   4 +-
 .../{include/mach => }/board-pb1176.h              |   4 +-
 .../{include/mach => }/board-pb11mp.h              |   4 +-
 .../mach-realview/{include/mach => }/board-pba8.h  |   4 +-
 .../mach-realview/{include/mach => }/board-pbx.h   |   4 +-
 arch/arm/mach-realview/core.c                      |   7 +-
 arch/arm/mach-realview/core.h                      |   2 -
 .../mach-realview/{include/mach => }/hardware.h    |   2 -
 arch/arm/mach-realview/include/mach/barriers.h     |   8 --
 arch/arm/mach-realview/include/mach/irqs.h         |  40 -------
 arch/arm/mach-realview/include/mach/memory.h       |  64 ----------
 arch/arm/mach-realview/include/mach/uncompress.h   |  77 ------------
 .../arm/mach-realview/{include/mach => }/irqs-eb.h |  20 +---
 .../mach-realview/{include/mach => }/irqs-pb1176.h |  21 ----
 .../mach-realview/{include/mach => }/irqs-pb11mp.h |  27 +----
 .../mach-realview/{include/mach => }/irqs-pba8.h   |  23 ----
 .../mach-realview/{include/mach => }/irqs-pbx.h    |  24 +---
 .../mach-realview/{include/mach => }/platform.h    |   2 -
 arch/arm/mach-realview/platsmp.c                   |   8 +-
 arch/arm/mach-realview/realview-dt.c               |   1 -
 arch/arm/mach-realview/realview_eb.c               |  12 +-
 arch/arm/mach-realview/realview_pb1176.c           |   6 +-
 arch/arm/mach-realview/realview_pb11mp.c           |  11 +-
 arch/arm/mach-realview/realview_pba8.c             |  14 +--
 arch/arm/mach-realview/realview_pbx.c              |  14 +--
 arch/arm/mm/Kconfig                                |  32 +++--
 drivers/clk/versatile/clk-realview.c               |  10 +-
 31 files changed, 229 insertions(+), 433 deletions(-)
 rename arch/arm/mach-realview/{include/mach => }/board-eb.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb1176.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb11mp.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/board-pba8.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pbx.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/hardware.h (95%)
 delete mode 100644 arch/arm/mach-realview/include/mach/barriers.h
 delete mode 100644 arch/arm/mach-realview/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-realview/include/mach/memory.h
 delete mode 100644 arch/arm/mach-realview/include/mach/uncompress.h
 rename arch/arm/mach-realview/{include/mach => }/irqs-eb.h (91%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb1176.h (88%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb11mp.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pba8.h (87%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pbx.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/platform.h (99%)

-- 
2.1.0.rc2
