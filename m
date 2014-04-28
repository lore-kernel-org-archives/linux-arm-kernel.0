From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 17:58:43 +0100
Subject: [PATCH 11/16] ARM: l2c: convert bcm_5301x to generic l2c
 initialisation
In-Reply-To: <20140428165631.GM26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
Message-ID: <E1Weot9-0002Q4-2C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also allows us to eliminate the .init_machine function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-bcm/bcm_5301x.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index 6bc9c31b1b0b..e9bcbdbce555 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -43,19 +43,14 @@ static void __init bcm5301x_init_early(void)
 			"imprecise external abort");
 }
 
-static void __init bcm5301x_dt_init(void)
-{
-	l2x0_of_init(0, ~0);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char __initconst *bcm5301x_dt_compat[] = {
 	"brcm,bcm4708",
 	NULL,
 };
 
 DT_MACHINE_START(BCM5301X, "BCM5301X")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.init_early	= bcm5301x_init_early,
-	.init_machine	= bcm5301x_dt_init,
 	.dt_compat	= bcm5301x_dt_compat,
 MACHINE_END
-- 
1.8.3.1
