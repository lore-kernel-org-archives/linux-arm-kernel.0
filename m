From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 19 Feb 2013 18:28:31 +0530
Subject: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
Message-ID: <1361278711-17672-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .init_late callback for OMAP3 has been missing for DT
builds, which causes a lot of late PM initializations to
be missed in turn.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 53cb380b..9b35329 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -103,6 +103,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
 	.restart	= omap3xxx_restart,
@@ -120,6 +121,7 @@ DT_MACHINE_START(OMAP3_GP_DT, "Generic OMAP3-GP (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
 	.timer		= &omap3_secure_timer,
 	.dt_compat	= omap3_gp_boards_compat,
 	.restart	= omap3xxx_restart,
-- 
1.7.9.5
