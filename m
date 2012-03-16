From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Fri, 16 Mar 2012 17:54:05 +0530
Subject: [PATCH 0/2] omap: board file changes to support dynamic irq alloc
Message-ID: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
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

I would request someone help me testing on other platforms.

Tarun Kanti DebBarma (2):
  omap1/board-files: fix OMAP_GPIO_IRQ usage with gpio_to_irq()
  omap2plus/board-files: fix OMAP_GPIO_IRQ usage with gpio_to_irq()

 arch/arm/mach-omap1/board-h2.c               |    8 ++++----
 arch/arm/mach-omap1/board-h3.c               |    8 ++++----
 arch/arm/mach-omap1/board-htcherald.c        |    6 +++---
 arch/arm/mach-omap1/board-innovator.c        |    4 ++--
 arch/arm/mach-omap1/board-nokia770.c         |    1 +
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
 21 files changed, 50 insertions(+), 44 deletions(-)
