From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Feb 2015 17:08:00 +0100
Subject: [PATCH, resent 00/10] ARM Realview multiplatform support
Message-ID: <1424966890-260805-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is from an old patch set of mine that I have decided to
update to the latest kernel, hopefully getting it fully merged
in 3.21.

We lose a few features here, but after discussions I've had
in the past, it seems unlikely that anyone would miss them.

A few of the changes are for ARM core code and need at least
an Ack from Russell, or we can try to have a shared git
branch for these if necessary.

Please review.

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

[re-sent with correct mailing list address, sorry for duplicate
 spam]

 arch/arm/Kconfig                                   |  16 ---
 arch/arm/mach-integrator/Kconfig                   | 132 ++++++++++++++++++---
 arch/arm/mach-realview/Kconfig                     |  65 +++++++---
 arch/arm/mach-realview/Makefile                    |   7 +-
 .../mach-realview/{include/mach => }/board-eb.h    |   4 +-
 .../{include/mach => }/board-pb1176.h              |   4 +-
 .../{include/mach => }/board-pb11mp.h              |   4 +-
 .../mach-realview/{include/mach => }/board-pba8.h  |   4 +-
 .../mach-realview/{include/mach => }/board-pbx.h   |   4 +-
 arch/arm/mach-realview/core.c                      |   6 +-
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
 31 files changed, 232 insertions(+), 432 deletions(-)
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
