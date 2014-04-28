From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:58:37 +0100
Subject: [PATCH 10/16] ARM: l2c: convert mvebu to generic l2c initialisation
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1Weot3-0002Pz-VB@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mvebu/board-v7.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index c6bd79f64744..48169caa56ea 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -59,9 +59,6 @@ static void __init mvebu_timer_and_clk_init(void)
 	clocksource_of_init();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init());
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_of_init(0, ~0);
-#endif
 
 	if (of_machine_is_compatible("marvell,armada375"))
 		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
@@ -109,6 +106,8 @@ static const char * const armada_370_xp_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= mvebu_dt_init,
 	.init_time	= mvebu_timer_and_clk_init,
@@ -122,6 +121,8 @@ static const char * const armada_375_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
@@ -134,6 +135,8 @@ static const char * const armada_38x_dt_compat[] = {
 };
 
 DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_38x_dt_compat,
-- 
1.8.3.1
