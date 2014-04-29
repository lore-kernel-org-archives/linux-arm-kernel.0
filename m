From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 29 Apr 2014 16:35:12 +0530
Subject: [PATCH v4 4/5] ARM: OMAP2+: Add machine entry for dra72x devices
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Message-ID: <1398769513-8736-5-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference from the dra74x devices is the missing .smp entry.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 90dbfdf..238ab0a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -240,13 +240,13 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_DRA7XX
-static const char *dra7xx_boards_compat[] __initconst = {
-	"ti,dra7xx",
+static const char *dra74x_boards_compat[] __initconst = {
+	"ti,dra742",
 	"ti,dra7",
 	NULL,
 };
 
-DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
+DT_MACHINE_START(DRA74X_DT, "Generic DRA74X (Flattened Device Tree)")
 	.reserve	= omap_reserve,
 	.smp		= smp_ops(omap4_smp_ops),
 	.map_io		= omap5_map_io,
@@ -255,7 +255,24 @@ DT_MACHINE_START(DRA7XX_DT, "Generic DRA7XX (Flattened Device Tree)")
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
 	.init_time	= omap5_realtime_timer_init,
-	.dt_compat	= dra7xx_boards_compat,
+	.dt_compat	= dra74x_boards_compat,
+	.restart	= omap44xx_restart,
+MACHINE_END
+
+static const char *dra72x_boards_compat[] __initconst = {
+	"ti,dra722",
+	NULL,
+};
+
+DT_MACHINE_START(DRA72X_DT, "Generic DRA72X (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap5_map_io,
+	.init_early	= dra7xx_init_early,
+	.init_late	= dra7xx_init_late,
+	.init_irq	= omap_gic_of_init,
+	.init_machine	= omap_generic_init,
+	.init_time	= omap5_realtime_timer_init,
+	.dt_compat	= dra72x_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
 #endif
-- 
1.7.9.5
