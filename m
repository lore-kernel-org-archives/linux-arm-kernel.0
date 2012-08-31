From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2012 17:52:28 -0700
Subject: [PATCH 4/9] ARM: OMAP2+: Remove unused nand_irq for GPMC
In-Reply-To: <20120831004828.28732.902.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
Message-ID: <20120831005228.28732.90454.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer needed and assumes a fixed IRQ number
that won't work with SPARSE_IRQ.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-flash.c            |    1 -
 include/linux/platform_data/mtd-nand-omap2.h |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index a1ef5f0..c8d4382 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -140,7 +140,6 @@ __init board_nand_init(struct mtd_partition *nand_parts,
 	board_nand_data.devsize		= nand_type;
 
 	board_nand_data.ecc_opt = OMAP_ECC_HAMMING_CODE_DEFAULT;
-	board_nand_data.gpmc_irq = OMAP_GPMC_IRQ_BASE + cs;
 	gpmc_nand_init(&board_nand_data);
 }
 #endif /* CONFIG_MTD_NAND_OMAP2 || CONFIG_MTD_NAND_OMAP2_MODULE */
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 290cef5..1a68c1e 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -24,7 +24,6 @@ struct omap_nand_platform_data {
 	struct gpmc_timings	*gpmc_t;
 	int			nr_parts;
 	bool			dev_ready;
-	int			gpmc_irq;
 	enum nand_io		xfer_type;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
