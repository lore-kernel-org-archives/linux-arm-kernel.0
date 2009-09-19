From: vikram.pandita@ti.com (Vikram Pandita)
Date: Fri, 18 Sep 2009 19:39:38 -0500
Subject: [PATCH v3 0/2] Cleanup DEBUG_LL infrastructure
Message-ID: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch1: clean up the DEBUG_LL infrastructure for run time detection
Patch2: add DEBUG_LL support for Zoom2 board that has external UART

Patchs are also hosted at:
git://dev.omapzoom.org/pub/scm/vikram/omap3.git debug-ll-ver3

Tested on OMAP3: SDP3430/Zoom2/Zoom1/Beagleboard
Will appreciate if some can verify for OMAP2 and OMAP1 boards

Vikram Pandita (2):
  OMAP1/2/3/4: DEBUG_LL run time detection
  OMAP: Zoom2: Add DEBUG_LL interface using Quart

 arch/arm/mach-omap2/board-zoom-debugboard.c   |    5 +-
 arch/arm/mach-omap2/board-zoom2.c             |   18 +++-
 arch/arm/plat-omap/Kconfig                    |   16 ---
 arch/arm/plat-omap/Makefile                   |    2 +-
 arch/arm/plat-omap/debug-low-level.c          |  125 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/debug-macro.S |   60 +++++-------
 arch/arm/plat-omap/include/mach/io.h          |    6 +
 arch/arm/plat-omap/include/mach/uncompress.h  |   27 +++---
 8 files changed, 188 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm/plat-omap/debug-low-level.c
