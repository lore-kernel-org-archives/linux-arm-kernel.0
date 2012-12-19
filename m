From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:42 -0800
Subject: [PATCH v2 7/7] arm: zynq: timer: Set clock_event cpumask
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <2a6829e8-3578-4fcf-b6d2-406576187abb@VA3EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timers are common to both A9 cores, so let's set the clock
event struct's cpumask accordingly, to all possible CPUs.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 7b2e047..f9fbc9c 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -267,6 +267,7 @@ static void __init zynq_ttc_setup_clockevent(struct device_node *np,
 	ttcce->ce.set_mode = xttcps_set_mode;
 	ttcce->ce.rating = 200;
 	ttcce->ce.irq = irq;
+	ttcce->ce.cpumask = cpu_possible_mask;
 
 	__raw_writel(0x23, ttcce->xttc.base_addr + XTTCPS_CNT_CNTRL_OFFSET);
 	__raw_writel(CLK_CNTRL_PRESCALE | CLK_CNTRL_PRESCALE_EN,
-- 
1.8.0.2
