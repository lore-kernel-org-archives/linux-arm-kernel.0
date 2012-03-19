From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Mon, 19 Mar 2012 17:36:53 +0530
Subject: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic irq alloc
Message-ID: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches incorporate changes to OMAP1 and OMAP2 platforms
board files whereby older references to OMAP_GPIO_IRQ macro are
now replaced with gpio_to_irq(), thereby getting rid of static
irq references.

Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
Commit: 9a0cee711448335ec43eae83272495e9334c0098

Test info:
OMAP1 Platforms:
Boot test on OMAP1710 H3.

OMAP2PLUS Platforms:
OMAP2430SDP, OMAP3430SDP, OMAP3630-ZOOM3, OMAP4430-SDP,
OMAP4430-PANDA, OMAP4430-BLAZE

I have also done gpio functional testing after merging Grant's:
git://git.secretlab.ca/git/linux-2.6.git gpio/next
on top of these patches.

Again, I would request someone help me testing on other platforms.

v2:
- Modified the patch subjects as per convention.
- Added a new patch to remove OMAP_GPIO_IRQ from ams_delta_serio driver.
- Added a new patch to remove OMAP_GPIO_IRQ macro definition.

Tarun Kanti DebBarma (4):
  ARM: OMAP1: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
  ARM: OMAP2+: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
  drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq() in
    ams_delta_serio_exit()
  ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition

 arch/arm/mach-omap1/board-h2.c               |    8 ++++----
 arch/arm/mach-omap1/board-h3.c               |    9 ++++-----
 arch/arm/mach-omap1/board-htcherald.c        |    6 +++---
 arch/arm/mach-omap1/board-innovator.c        |    4 ++--
 arch/arm/mach-omap1/board-nokia770.c         |    2 +-
 arch/arm/mach-omap1/board-osk.c              |   12 ++++++------
 arch/arm/mach-omap1/board-palmte.c           |    2 +-
 arch/arm/mach-omap1/board-palmtt.c           |    2 +-
 arch/arm/mach-omap1/board-palmz71.c          |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c        |   16 +++++++---------
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    6 ++++--
 arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 arch/arm/plat-omap/include/plat/gpio.h       |    4 ----
 drivers/input/serio/ams_delta_serio.c        |    2 +-
 23 files changed, 51 insertions(+), 51 deletions(-)
