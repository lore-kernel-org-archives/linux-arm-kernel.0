From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:40 +0100
Subject: [PATCH 40/40] ARM: ux500: Remove ATAG booting support for Snowball
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-41-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index f5b1274..463e321 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -77,20 +77,3 @@ struct pl022_ssp_controller ssp0_plat = {
 	 */
 	.num_chipselect = 5,
 };
-
-static void __init snowball_init_machine(void)
-{
-	/* This board has full regulator constraints */
-	regulator_has_full_constraints();
-}
-
-MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
-	.atag_offset	= 0x100,
-	.smp		= smp_ops(ux500_smp_ops),
-	.map_io		= u8500_map_io,
-	.init_irq	= ux500_init_irq,
-	/* we re-use nomadik timer here */
-	.init_time	= ux500_timer_init,
-	.init_machine	= snowball_init_machine,
-	.init_late	= NULL,
-MACHINE_END
-- 
1.8.1.2
