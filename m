From: ryan@bluewatersys.com (Ryan Mallon)
Date: Sat,  5 Jun 2010 18:05:50 +1200
Subject: [PATCH 0/5] SPEAr3xx: Unify build of SPEAr3xx platforms
Message-ID: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the SPEAr3xx code to allow all three SPEAr3xx platforms to be
built into a single kernel.

I do not have access to any SPEAr3xx hardware, so the patch series is
build tested only.

Ryan Mallon (5):
  SPEAr3xx: Make local structres static
  SPEAR3xx: Rename register/irq defines to remove naming conflicts
  SPEAr3xx: Rework pmx_dev code to remove conflicts
  SPEAr3xx: Rework KConfig to allow all boards to be compiled in
  SPEAr3xx: Replace defconfigs with single unfied defconfig

 arch/arm/configs/spear300_defconfig            |  773 -----------------------
 arch/arm/configs/spear310_defconfig            |  775 ------------------------
 arch/arm/configs/spear320_defconfig            |  775 ------------------------
 arch/arm/configs/spear3xx_defconfig            |  775 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/Kconfig                 |   30 +-
 arch/arm/mach-spear3xx/Kconfig300              |   17 -
 arch/arm/mach-spear3xx/Kconfig310              |   17 -
 arch/arm/mach-spear3xx/Kconfig320              |   17 -
 arch/arm/mach-spear3xx/include/mach/generic.h  |  139 ++---
 arch/arm/mach-spear3xx/include/mach/irqs.h     |  195 +++---
 arch/arm/mach-spear3xx/include/mach/spear300.h |   26 +-
 arch/arm/mach-spear3xx/include/mach/spear310.h |   44 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h |   50 +-
 arch/arm/mach-spear3xx/spear300.c              |  135 ++--
 arch/arm/mach-spear3xx/spear300_evb.c          |   26 +-
 arch/arm/mach-spear3xx/spear310.c              |  137 +++--
 arch/arm/mach-spear3xx/spear310_evb.c          |   42 +-
 arch/arm/mach-spear3xx/spear320.c              |  247 ++++----
 arch/arm/mach-spear3xx/spear320_evb.c          |   36 +-
 arch/arm/mach-spear3xx/spear3xx.c              |  124 ++--
 20 files changed, 1387 insertions(+), 2993 deletions(-)
 delete mode 100644 arch/arm/configs/spear300_defconfig
 delete mode 100644 arch/arm/configs/spear310_defconfig
 delete mode 100644 arch/arm/configs/spear320_defconfig
 create mode 100644 arch/arm/configs/spear3xx_defconfig
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320
