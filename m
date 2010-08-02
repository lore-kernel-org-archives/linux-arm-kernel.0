From: s-ghorai@ti.com (Sukumar Ghorai)
Date: Mon,  2 Aug 2010 21:19:48 +0530
Subject: [PATCH v4 0/4] nand prefetch-irq support and ecc layout chanage
Message-ID: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

   The following set of patches applies on top of omap-for-linus. 
   
   v4: Comments incorporated
   
   v3: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg32071.html
   	Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31963.html
	
   v2: Rebase on latest codebase and previous patch(posted).	
	http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31471.html

   v1: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg26666.html

Sukumar Ghorai (4):
	omap3: nand: prefetch in irq mode support
	omap: nand: configurable fifo threshold to gain the throughput
	omap: nand: ecc layout select from board file
	omap: nand: making ecc layout as compatible with romcode ecc

 arch/arm/mach-omap2/board-flash.c      |    5 +-
 arch/arm/mach-omap2/gpmc.c             |   15 ++-
 arch/arm/plat-omap/include/plat/gpmc.h |    9 +-
 arch/arm/plat-omap/include/plat/irqs.h |    1 +
 arch/arm/plat-omap/include/plat/nand.h |    7 +
 drivers/mtd/nand/Kconfig               |   14 ++-
 drivers/mtd/nand/omap2.c               |  277 ++++++++++++++++++++++++++++---
 7 files changed, 294 insertions(+), 34 deletions(-)
