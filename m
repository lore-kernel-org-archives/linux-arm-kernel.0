From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 May 2014 21:44:22 -0500
Subject: [PATCH v2 4/6] ARM: sunxi: Remove init_machine callback
In-Reply-To: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399430664-29091-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399430664-29091-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_machine hook is now at its default value. We can remove it.

Even though the sun4i and sun7i machines are nothing more than generic machines
now, leave them in so that we won't have to add them back if needed, and so
that the machine is still displayed in /proc/cpuinfo.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 1c62a0a021d7..efb2f93b02e6 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -12,17 +12,11 @@
 
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
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
@@ -31,7 +25,6 @@ static const char * const sunxi_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
-	.init_machine	= sunxi_dt_init,
 	.dt_compat	= sunxi_board_dt_compat,
 MACHINE_END
 
@@ -49,7 +42,6 @@ static void __init sun6i_timer_init(void)
 }
 
 DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
-	.init_machine	= sunxi_dt_init,
 	.init_time	= sun6i_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
 	.smp		= smp_ops(sun6i_smp_ops),
@@ -61,6 +53,5 @@ static const char * const sun7i_board_dt_compat[] = {
 };
 
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
-	.init_machine	= sunxi_dt_init,
 	.dt_compat	= sun7i_board_dt_compat,
 MACHINE_END
-- 
1.9.1
