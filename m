From: zonque@gmail.com (Daniel Mack)
Date: Mon, 22 Oct 2012 21:55:56 +0200
Subject: [PATCH 2/4] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
In-Reply-To: <1350935758-9215-1-git-send-email-zonque@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
Message-ID: <1350935758-9215-3-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 8607735..c3616c6 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -92,7 +92,7 @@ static int omap2_nand_gpmc_retime(
 static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
-	if (!cpu_is_omap34xx()) {
+	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
 		pr_err("BCH ecc is not supported on this CPU\n");
 		return 0;
 	}
-- 
1.7.11.7
