From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 18 Nov 2010 19:59:51 +0200
Subject: [PATCH] arm: omap2: timer-gp: delete unused variable
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <1290103191-360-7-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Delete a redundant local variable.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/timer-gp.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index e13c29e..f9052e1 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -203,7 +203,7 @@ static struct clocksource clocksource_gpt = {
 static void __init omap2_gp_clocksource_init(void)
 {
 	static struct omap_dm_timer *gpt;
-	u32 tick_rate, tick_period;
+	u32 tick_rate;
 	static char err1[] __initdata = KERN_ERR
 		"%s: failed to request dm-timer\n";
 	static char err2[] __initdata = KERN_ERR
@@ -216,7 +216,6 @@ static void __init omap2_gp_clocksource_init(void)
 
 	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
-	tick_period = (tick_rate / HZ) - 1;
 
 	omap_dm_timer_set_load_start(gpt, 1, 0);
 
-- 
1.5.6.5
