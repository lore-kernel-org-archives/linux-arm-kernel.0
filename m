From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Wed, 21 Dec 2011 19:13:33 +0530
Subject: [PATCH v7 0/8] ARM: davinci:add support for dm644x vpbe display driver
Message-ID: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
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
1. patches 2,3 and 4 from last set pulled by Sekhar
2. Some description changes.
3. Header inclusion sequence changes.
4. Deletion of a platform file which was missed out.


Manjunath Hadli (8):
  davinci: vpif: remove machine specific inclusion from driver
  ARM: davinci: create new common platform header for davinci
  davinci: eliminate use of IO_ADDRESS() on sysmod
  davinci: dm644x: Replace register base value with a defined macro
  davinci: dm644x: change vpfe capture structure variables for
    consistency
  davinci: dm644x: move vpfe init from soc to board specific files
  davinci: dm644x: add support for v4l2 video display
  davinci: dm644x EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm355-evm.c       |    3 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |    3 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |    3 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |  134 +++++++++++++++++--
 arch/arm/mach-davinci/board-dm646x-evm.c      |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |    3 +-
 arch/arm/mach-davinci/board-sffsdr.c          |    3 +-
 arch/arm/mach-davinci/davinci.h               |   99 ++++++++++++++
 arch/arm/mach-davinci/devices.c               |   25 +++--
 arch/arm/mach-davinci/dm355.c                 |    3 +-
 arch/arm/mach-davinci/dm365.c                 |    3 +-
 arch/arm/mach-davinci/dm644x.c                |  179 ++++++++++++++++++++++---
 arch/arm/mach-davinci/dm646x.c                |    3 +-
 arch/arm/mach-davinci/include/mach/dm355.h    |   32 -----
 arch/arm/mach-davinci/include/mach/dm365.h    |   36 -----
 arch/arm/mach-davinci/include/mach/dm644x.h   |   40 ------
 arch/arm/mach-davinci/include/mach/dm646x.h   |   34 -----
 arch/arm/mach-davinci/include/mach/hardware.h |    2 -
 drivers/media/video/davinci/vpif.h            |    2 -
 drivers/media/video/davinci/vpif_display.c    |    2 -
 include/media/davinci/vpif_types.h            |    2 +
 sound/soc/codecs/cq93vc.c                     |    2 -
 22 files changed, 413 insertions(+), 202 deletions(-)
 create mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h
