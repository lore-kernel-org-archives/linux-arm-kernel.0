From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 15:06:37 +0200
Subject: [PATCH 05/13] AT91: dt: Remove init_time definitions
In-Reply-To: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1403701605-26678-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current AT91 DT boards have a completely generic init_time definition.
Remove them from the machine declaration.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/board-dt-sam9.c  | 11 -----------
 arch/arm/mach-at91/board-dt-sama5.c | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index a9fcdadfd929..3f80ceb3f444 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -14,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -26,15 +25,6 @@
 #include "board.h"
 #include "generic.h"
 
-
-static void __init sam9_dt_timer_init(void)
-{
-#if defined(CONFIG_COMMON_CLK)
-	of_clk_init(NULL);
-#endif
-	clocksource_of_init();
-}
-
 static const struct of_device_id irq_of_match[] __initconst = {
 
 	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
@@ -53,7 +43,6 @@ static const char *at91_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM (Device Tree)")
 	/* Maintainer: Atmel */
-	.init_time	= sam9_dt_timer_init,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic_handle_irq,
 	.init_early	= at91_dt_initialize,
diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
index c07dd2395f36..030f4b65f449 100644
--- a/arch/arm/mach-at91/board-dt-sama5.c
+++ b/arch/arm/mach-at91/board-dt-sama5.c
@@ -17,7 +17,6 @@
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -28,14 +27,6 @@
 #include "at91_aic.h"
 #include "generic.h"
 
-static void __init sama5_dt_timer_init(void)
-{
-#if defined(CONFIG_COMMON_CLK)
-	of_clk_init(NULL);
-#endif
-	clocksource_of_init();
-}
-
 static const struct of_device_id irq_of_match[] __initconst = {
 
 	{ .compatible = "atmel,sama5d3-aic", .data = at91_aic5_of_init },
@@ -81,7 +72,6 @@ static const char *sama5_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
 	/* Maintainer: Atmel */
-	.init_time	= sama5_dt_timer_init,
 	.map_io		= at91_map_io,
 	.handle_irq	= at91_aic5_handle_irq,
 	.init_early	= at91_dt_initialize,
-- 
2.0.0
