From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 18 Jan 2013 21:02:18 +0530
Subject: [PATCH 2/5] ARM: OMAP2+: timer: Update the OMAP5 clocksource name as
 per clock data
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1358523141-12295-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 clockdata has different sys clock clock node name. Fix the timer code
to take care of it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 691aa67..a0a1b14 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -62,6 +62,7 @@
 #define OMAP2_MPU_SOURCE	"sys_ck"
 #define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
 #define OMAP4_MPU_SOURCE	"sys_clkin_ck"
+#define OMAP5_MPU_SOURCE	"sys_clkin"
 #define OMAP2_32K_SOURCE	"func_32k_ck"
 #define OMAP3_32K_SOURCE	"omap_32k_fck"
 #define OMAP4_32K_SOURCE	"sys_32k_ck"
@@ -498,7 +499,7 @@ static void __init realtime_counter_init(void)
 		pr_err("%s: ioremap failed\n", __func__);
 		return;
 	}
-	sys_clk = clk_get(NULL, "sys_clkin_ck");
+	sys_clk = clk_get(NULL, OMAP5_MPU_SOURCE);
 	if (IS_ERR(sys_clk)) {
 		pr_err("%s: failed to get system clock handle\n", __func__);
 		iounmap(base);
@@ -638,7 +639,7 @@ OMAP_SYS_TIMER(4, local);
 
 #ifdef CONFIG_SOC_OMAP5
 OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
-			2, OMAP4_MPU_SOURCE);
+			2, OMAP5_MPU_SOURCE);
 static void __init omap5_realtime_timer_init(void)
 {
 	int err;
-- 
1.7.9.5
