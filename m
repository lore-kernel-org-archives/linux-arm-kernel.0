From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Feb 2012 09:31:59 -0800
Subject: [PATCH] ARM: OMAP2+: Fix GPMC errors when CONFIG_MTD_NAND_OMAP2 is
 a module
Message-ID: <20120229173159.GM18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we can get:

ERROR: "gpmc_calculate_ecc" [drivers/mtd/nand/omap2.ko] undefined!
ERROR: "gpmc_enable_hwecc" [drivers/mtd/nand/omap2.ko] undefined!

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -888,6 +888,7 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 	gpmc_write_reg(GPMC_ECC_CONFIG, val);
 	return 0;
 }
+EXPORT_SYMBOL(gpmc_enable_hwecc);
 
 /**
  * gpmc_calculate_ecc - generate non-inverted ecc bytes
@@ -918,3 +919,4 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 	gpmc_ecc_used = -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL(gpmc_calculate_ecc);
