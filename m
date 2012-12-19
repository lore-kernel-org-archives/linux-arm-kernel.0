From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:41 -0800
Subject: [PATCH v2 6/7] arm: zynq: timer: Fix comment style
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <07f27d3f-d6cd-44e6-95fe-739f9583a3bd@DB3EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing multi line comment style at two locations.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 2b23d0f..7b2e047 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -36,7 +36,8 @@
 
 #define XTTCPS_CNT_CNTRL_DISABLE_MASK	0x1
 
-/* Setup the timers to use pre-scaling, using a fixed value for now that will
+/*
+ * Setup the timers to use pre-scaling, using a fixed value for now that will
  * work across most input frequency, but it may need to be more dynamic
  */
 #define PRESCALE_EXPONENT	11	/* 2 ^ PRESCALE_EXPONENT = PRESCALE */
@@ -89,8 +90,10 @@ static void xttcps_set_interval(struct xttcps_timer *timer,
 
 	__raw_writel(cycles, timer->base_addr + XTTCPS_INTR_VAL_OFFSET);
 
-	/* Reset the counter (0x10) so that it starts from 0, one-shot
-	   mode makes this needed for timing to be right. */
+	/*
+	 * Reset the counter (0x10) so that it starts from 0, one-shot
+	 * mode makes this needed for timing to be right.
+	 */
 	ctrl_reg |= CNT_CNTRL_RESET;
 	ctrl_reg &= ~XTTCPS_CNT_CNTRL_DISABLE_MASK;
 	__raw_writel(ctrl_reg, timer->base_addr + XTTCPS_CNT_CNTRL_OFFSET);
-- 
1.8.0.2
