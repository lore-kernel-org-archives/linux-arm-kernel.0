From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Thu, 8 Dec 2011 19:25:23 +0530
Subject: [PATCH v4 0/5] ARM: davinci: re-arrange definitions to have a common
 davinci header
Message-ID: <1323352528-1207-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-arrange definitions and remove unnecessary code so that we can
have a common header for all davinci platforms. This will enable
us to share defines and enable common routines to be used without
polluting hardware.h.
 This patch set forms the base for a later set of patches for having
a common system module base address (DAVINCI_SYSTEM_MODULE_BASE).

Changes from previous version:
1. Addressed Shekhar's comments for non-inclusion of mach headers from core.
2. Move the mach header from include to mach

Manjunath Hadli (5):
  davinci: vpif: remove obsolete header file inclusion
  ARM: davinci: dm644x: remove the macros from the header to move to c
    file
  ARM: davinci: dm365: remove the macros from the header to move to c
    file
  ARM: davinci: dm646x: remove the macros from the header to move to c
    file
  ARM: davinci: create new common platform header for davinci

 arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/davinci.h             |   88 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c               |    2 +-
 arch/arm/mach-davinci/dm365.c               |   18 +++++-
 arch/arm/mach-davinci/dm644x.c              |    9 +++-
 arch/arm/mach-davinci/dm646x.c              |    9 +++-
 arch/arm/mach-davinci/include/mach/dm355.h  |   32 ----------
 arch/arm/mach-davinci/include/mach/dm365.h  |   52 ----------------
 arch/arm/mach-davinci/include/mach/dm644x.h |   47 --------------
 arch/arm/mach-davinci/include/mach/dm646x.h |   41 ------------
 drivers/media/video/davinci/vpif.h          |    2 +-
 drivers/media/video/davinci/vpif_display.c  |    2 -
 18 files changed, 130 insertions(+), 186 deletions(-)
 create mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
