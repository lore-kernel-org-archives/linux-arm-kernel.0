From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:38 +0100
Subject: [PATCH 38/40] ARM: ux500: Remove ATAG booting support for U8520
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-39-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 705b0d7..9a454b1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -78,12 +78,6 @@ struct pl022_ssp_controller ssp0_plat = {
 	.num_chipselect = 5,
 };
 
-static void __init mop500_init_machine(void)
-{
-	/* This board has full regulator constraints */
-	regulator_has_full_constraints();
-}
-
 static void __init snowball_init_machine(void)
 {
 	/* This board has full regulator constraints */
@@ -96,15 +90,6 @@ static void __init hrefv60_init_machine(void)
 	regulator_has_full_constraints();
 }
 
-MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
-	.atag_offset	= 0x100,
-	.map_io		= u8500_map_io,
-	.init_irq	= ux500_init_irq,
-	.init_time	= ux500_timer_init,
-	.init_machine	= mop500_init_machine,
-	.init_late	= NULL,
-MACHINE_END
-
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.atag_offset	= 0x100,
 	.smp		= smp_ops(ux500_smp_ops),
-- 
1.8.1.2
