From: tony@atomide.com (Tony Lindgren)
Date: Tue, 04 Oct 2011 17:45:36 -0700
Subject: [PATCH 0/4] initialize omap SRAM later on with __arm_ioremap_exec()
Message-ID: <20111005004339.26980.31149.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Related to the omap static mapping, here's a first take on moving the
SRAM init to happen later so we can do generic map_io.

Still working on a similar patch for omap1, will send it a bit later.

Regards,

Tony

---

Tony Lindgren (4):
      ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
      ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
      ARM: OMAP: Remove calls to SRAM allocations for framebuffer
      ARM: OMAP: Map SRAM later on with ioremap_exec()


 arch/arm/include/asm/io.h                |    1 
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 --
 arch/arm/mach-omap2/io.c                 |  108 ++++++++++++++----------------
 arch/arm/mm/ioremap.c                    |   22 ++++++
 arch/arm/plat-omap/include/plat/common.h |    1 
 arch/arm/plat-omap/sram.c                |   85 ++++++------------------
 6 files changed, 94 insertions(+), 130 deletions(-)

-- 
Signature
