From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 7 Nov 2012 12:43:00 -0600
Subject: [PATCH 1/3] ARM: OMAP4: Update timer clock aliases
In-Reply-To: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
References: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352313782-21602-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "ARM: dts: OMAP4: Update timer addresses" updated the device-tree
names of the OMAP4 timers 5-7 because the default address for the timers
was changed from the L3 address to the MPU private address. When booting
with device-tree, this introduces a regression when attempting to set
the parent clock of timers 5-7 to the sys_clk_div_ck. Therefore, update
the clock aliases for timer 5-7 to reflect the updated device-tree name
for the timers.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
This change is needed for v3.8 as the patch [1] to update the default
timer addresses is queued for that release.

[1] http://marc.info/?l=linux-omap&m=135178500008690&w=2

 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 6efc30c..8f197eb 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3341,10 +3341,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
 	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("49038000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4903e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
+	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
 	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
 };
 
-- 
1.7.9.5
