From: zonque@gmail.com (Daniel Mack)
Date: Wed, 28 Nov 2012 17:58:57 +0100
Subject: [PATCH v5 2/4] ARM: OMAP: gpmc-nand: drop __init annotation
In-Reply-To: <1354121939-11246-1-git-send-email-zonque@gmail.com>
References: <1354121939-11246-1-git-send-email-zonque@gmail.com>
Message-ID: <1354121939-11246-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpmc_nand_init() will be called from another driver's probe() function,
so the easiest way to prevent section mismatches is to drop the
annotation here.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 8607735..f9f23a2 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -89,7 +89,7 @@ static int omap2_nand_gpmc_retime(
 	return 0;
 }
 
-static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
+static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
 	if (!cpu_is_omap34xx()) {
@@ -110,8 +110,8 @@ static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 	return 1;
 }
 
-int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
-			  struct gpmc_timings *gpmc_t)
+int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
+		   struct gpmc_timings *gpmc_t)
 {
 	int err	= 0;
 	struct device *dev = &gpmc_nand_device.dev;
-- 
1.7.11.7
