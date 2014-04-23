From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 17:04:36 +0200
Subject: [PATCH 5/5] ARM: sunxi: Remove sun4i and sun7i machine definitions
In-Reply-To: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398265476-29373-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun4i and sun7i machines are nothing more than a generic machine now, we
can completely remove them.

Only stays the sun6i machine, that needs to have its reset controller enabled
before the timers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 1c62a0a021d7..205cd75f63f5 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -12,29 +12,11 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clocksource.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 
 #include "common.h"
 
-static void __init sunxi_dt_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char * const sunxi_board_dt_compat[] = {
-	"allwinner,sun4i-a10",
-	"allwinner,sun5i-a10s",
-	"allwinner,sun5i-a13",
-	NULL,
-};
-
-DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
-	.init_machine	= sunxi_dt_init,
-	.dt_compat	= sunxi_board_dt_compat,
-MACHINE_END
-
 static const char * const sun6i_board_dt_compat[] = {
 	"allwinner,sun6i-a31",
 	NULL,
@@ -49,18 +31,7 @@ static void __init sun6i_timer_init(void)
 }
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
-	.init_machine	= sunxi_dt_init,
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
 	.smp		= smp_ops(sun6i_smp_ops),
 MACHINE_END
-
-static const char * const sun7i_board_dt_compat[] = {
-	"allwinner,sun7i-a20",
-	NULL,
-};
-
-DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
-	.init_machine	= sunxi_dt_init,
-	.dt_compat	= sun7i_board_dt_compat,
-MACHINE_END
-- 
1.9.1
