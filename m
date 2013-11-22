From: joelf@ti.com (Joel Fernandes)
Date: Thu, 21 Nov 2013 19:56:54 -0600
Subject: [PATCH 8/8] ARM: AM33xx: Move to using omap_generic_timer_init for
 init_time
In-Reply-To: <1385085414-9034-1-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
Message-ID: <1385085414-9034-9-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier patch in this series introduced a function omap_generic_timer_init
for all DT platforms. Use it for AM33xx SoC.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 87162e1..cfda6bc 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -180,7 +180,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
 	.init_irq	= omap_intc_of_init,
 	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap3_gptimer_timer_init,
+	.init_time	= omap_generic_timer_init,
 	.dt_compat	= am33xx_boards_compat,
 	.restart	= am33xx_restart,
 MACHINE_END
-- 
1.8.1.2
