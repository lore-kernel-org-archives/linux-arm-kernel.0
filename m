From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Sep 2015 08:42:40 -0500
Subject: [PATCH 2/2] arm: omap2: board-generic: use omap4_local_timer_init for
 AM437x
In-Reply-To: <1442238160-5674-1-git-send-email-balbi@ti.com>
References: <1442238160-5674-1-git-send-email-balbi@ti.com>
Message-ID: <1442238160-5674-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x-based boards, can use omap4_local_timer_init()
just fine. Let's use that instead.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 24c9afc9e8a7..89bf39663d61 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -279,7 +279,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap3_gptimer_timer_init,
+	.init_time	= omap4_local_timer_init,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
-- 
2.5.0
