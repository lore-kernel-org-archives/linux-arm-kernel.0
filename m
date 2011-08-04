From: khilman@ti.com (Kevin Hilman)
Date: Thu,  4 Aug 2011 08:45:04 -0700
Subject: [PATCH 0/6] OMAP: misc. PM-related fixes for v3.1-rc
Message-ID: <1312472710-31758-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here's my current collection of PM-related fixes for the -rc cycle.

They are based on the next/board branch of Arnd's arm-soc tree (which
has already been merged by Linus) and are also available in the
for_3.1/pm-fixes branch of my tree:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin



Colin Cross (1):
  OMAP2+: PM: SmartReflex: use put_sync_suspend for IRQ-safe disabling

Kevin Hilman (4):
  OMAP2+: Kconfig: don't select PM in OMAP2PLUS_TYPICAL
  OMAP1: enable GENERIC_IRQ_CHIP
  OMAP3: beagle: don't touch omap_device internals
  OMAP: McBSP: use existing macros for converting between devices

Nishanth Menon (1):
  OMAP3+: SR: ensure pm-runtime callbacks can be invoked with IRQs
    disabled

 arch/arm/mach-omap2/Kconfig             |    1 -
 arch/arm/mach-omap2/board-omap3beagle.c |   23 ++++++++++-------------
 arch/arm/mach-omap2/smartreflex.c       |    3 ++-
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/mcbsp.c              |    6 +++---
 5 files changed, 16 insertions(+), 18 deletions(-)

-- 
1.7.6
