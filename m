From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:37:49 -0800
Subject: [PATCH 1/4] ARM: OMAP2+: Add board-generic.c entry for ti81xx
In-Reply-To: <1421192272-20754-1-git-send-email-tony@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
Message-ID: <1421192272-20754-2-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows booting ti81xx boards with with when a .dts
file is in place.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-generic.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 608079a..e95b8f7 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -142,6 +142,40 @@ DT_MACHINE_START(AM3517_DT, "Generic AM3517 (Flattened Device Tree)")
 	.dt_compat	= am3517_boards_compat,
 	.restart	= omap3xxx_restart,
 MACHINE_END
+
+static const char *const ti814x_boards_compat[] __initconst = {
+	"ti,dm8148",
+	"ti,dm814",
+	NULL,
+};
+
+DT_MACHINE_START(TI81XX_DT, "Generic ti814x (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti814x_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= ti81xx_init_late,
+	.init_time	= omap3_gptimer_timer_init,
+	.dt_compat	= ti814x_boards_compat,
+	.restart	= ti81xx_restart,
+MACHINE_END
+
+static const char *const ti816x_boards_compat[] __initconst = {
+	"ti,dm8168",
+	"ti,dm816",
+	NULL,
+};
+
+DT_MACHINE_START(TI816X_DT, "Generic ti816x (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= ti81xx_map_io,
+	.init_early	= ti816x_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= ti81xx_init_late,
+	.init_time	= omap3_gptimer_timer_init,
+	.dt_compat	= ti816x_boards_compat,
+	.restart	= ti81xx_restart,
+MACHINE_END
 #endif
 
 #ifdef CONFIG_SOC_AM33XX
-- 
2.1.4
