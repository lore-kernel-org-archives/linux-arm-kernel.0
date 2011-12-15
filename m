From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Thu, 15 Dec 2011 17:41:49 +0530
Subject: [PATCH v6 00/11] ARM: davinci:add support for dm644x vpbe display
 driver
Message-ID: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-arrange definitions and remove unnecessary code so that we can
have a common header for all davinci platforms. This will enable
us to share defines and enable common routines to be used without
polluting hardware.h. 

This is consistent with Russel's pet peaves notes regarding
non-pollution of include/mach.

Having this as the base, have a common system module
base address (DAVINCI_SYSTEM_MODULE_BASE) and removing IO_ADDRESS
macro,add support for dm644x VPBE display driver.

Changes from last version:
1. Sergei's comments for changing form XXX_REG_BASE to XXX_BASE.
2. Removal of unnecassary typecasting.

Manjunath Hadli (11):
  davinci: vpif: remove obsolete header file inclusion
  ARM: davinci: dm644x: remove the macros from the header to move to c
    file
  ARM: davinci: dm365: remove the macros from the header to move to c
    file
  ARM: davinci: dm646x: remove the macros from the header to move to c
    file
  ARM: davinci: create new common platform header for davinci
  davinci: eliminate use of IO_ADDRESS() on sysmod
  davinci: dm644x: Replace register base value with a defined macro
  davinci: dm644x: change vpfe capture structure variables for
    consistency
  davinci: dm644x: move vpfe init from soc to board specific files
  davinci: dm644x: add support for v4l2 video display
  davinci: dm644x EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm355-evm.c       |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |  133 ++++++++++++++++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c          |    2 +-
 arch/arm/mach-davinci/davinci.h               |  101 +++++++++++++
 arch/arm/mach-davinci/devices.c               |   25 ++--
 arch/arm/mach-davinci/dm355.c                 |    3 +-
 arch/arm/mach-davinci/dm365.c                 |   19 +++-
 arch/arm/mach-davinci/dm644x.c                |  186 ++++++++++++++++++++++---
 arch/arm/mach-davinci/dm646x.c                |   10 ++-
 arch/arm/mach-davinci/include/mach/dm355.h    |   32 -----
 arch/arm/mach-davinci/include/mach/dm365.h    |   52 -------
 arch/arm/mach-davinci/include/mach/dm644x.h   |   47 ------
 arch/arm/mach-davinci/include/mach/dm646x.h   |   41 ------
 arch/arm/mach-davinci/include/mach/hardware.h |    2 -
 drivers/media/video/davinci/vpif.h            |    2 +-
 drivers/media/video/davinci/vpif_display.c    |    2 -
 20 files changed, 438 insertions(+), 229 deletions(-)
 create mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
