From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Aug 2013 15:41:44 +0530
Subject: [PATCH 1/2] ARM: AM335x: Get rid of unused sram init function
In-Reply-To: <1377598305-15539-1-git-send-email-rnayak@ti.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
Message-ID: <1377598305-15539-2-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the empty am33xx_sram_init() function.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/sram.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
index 4bd0968..305fc2b 100644
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -285,11 +285,6 @@ static inline int omap34xx_sram_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-static inline int am33xx_sram_init(void)
-{
-	return 0;
-}
-
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -299,8 +294,6 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
-	else if (soc_is_am33xx())
-		am33xx_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 
-- 
1.7.9.5
