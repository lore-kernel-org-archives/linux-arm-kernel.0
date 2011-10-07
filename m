From: tony@atomide.com (Tony Lindgren)
Date: Fri, 07 Oct 2011 12:45:40 -0700
Subject: [PATCH 0/7] Repost of omap SRAM map_io changes
Message-ID: <20111007194242.18205.64009.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's a repost of the original patches with minimal changes
to fix some compile warnings and with the acks added.

There's also one new patch to warn about trying to use the
omap_ioremap too early that's good to have for some sanity
checks.

These patches are against the dt branch in linux-omap tree
because of dependencies to earlier cleanup.

Regards,

Tony

---

Tony Lindgren (7):
      ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
      ARM: OMAP1: Use generic map_io, init_early and init_irq
      ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
      ARM: OMAP: Remove calls to SRAM allocations for framebuffer
      ARM: OMAP: Map SRAM later on with ioremap_exec()
      ARM: OMAP: Move set_globals initialization to happen in init_early
      ARM: OMAP: Warn if omap_ioremap is called before SoC detection


 arch/arm/include/asm/io.h                |    1 
 arch/arm/mach-omap1/board-ams-delta.c    |   16 +---
 arch/arm/mach-omap1/board-fsample.c      |   76 +++++++++---------
 arch/arm/mach-omap1/board-generic.c      |   16 +---
 arch/arm/mach-omap1/board-h2.c           |   16 +---
 arch/arm/mach-omap1/board-h3.c           |   16 +---
 arch/arm/mach-omap1/board-htcherald.c    |   12 +--
 arch/arm/mach-omap1/board-innovator.c    |   36 ++++-----
 arch/arm/mach-omap1/board-nokia770.c     |   34 +++-----
 arch/arm/mach-omap1/board-osk.c          |   16 +---
 arch/arm/mach-omap1/board-palmte.c       |   16 +---
 arch/arm/mach-omap1/board-palmtt.c       |   16 +---
 arch/arm/mach-omap1/board-palmz71.c      |   18 +---
 arch/arm/mach-omap1/board-perseus2.c     |   75 +++++++++---------
 arch/arm/mach-omap1/board-sx1.c          |   17 +---
 arch/arm/mach-omap1/board-voiceblue.c    |   16 +---
 arch/arm/mach-omap1/devices.c            |    3 +
 arch/arm/mach-omap1/io.c                 |   57 ++++++-------
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 --
 arch/arm/mach-omap2/board-ti8168evm.c    |    1 
 arch/arm/mach-omap2/common.c             |   50 +++++-------
 arch/arm/mach-omap2/control.c            |   14 +--
 arch/arm/mach-omap2/io.c                 |  127 +++++++++++++++---------------
 arch/arm/mach-omap2/io.h                 |    7 --
 arch/arm/mach-omap2/omap-smp.c           |    7 +-
 arch/arm/mach-omap2/prcm.c               |   19 +---
 arch/arm/mach-omap2/sdrc.c               |   13 +--
 arch/arm/mm/ioremap.c                    |   21 +++++
 arch/arm/plat-omap/include/plat/common.h |   17 ++--
 arch/arm/plat-omap/include/plat/io.h     |   29 ++++++-
 arch/arm/plat-omap/io.c                  |   10 ++
 arch/arm/plat-omap/sram.c                |   85 +++++---------------
 32 files changed, 356 insertions(+), 508 deletions(-)

-- 
Signature
