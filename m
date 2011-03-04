From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 4 Mar 2011 16:01:43 +0100
Subject: [PATCH 1/2] Revert "OMAP4: hwmod data: Prevent timer1 to be reset and idle during init"
Message-ID: <mailman.160.1299256775.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit: 38698be:
OMAP2+: clockevent: set up GPTIMER clockevent hwmod right before timer init

Fixed properly the issue with early init for the timer1

So reverts commit 3b03b58dab847883e6b9a431558c7d8e43fa94c6 that is now
generated a warning at boot time.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dbcdf7..7b72316 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,7 +4005,6 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
 	.main_clk	= "timer1_fck",
-- 
1.7.0.4
