From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:30 -0500
Subject: [PATCH 15/18] ARM: imx: Remove the SoC relating codes in
 mxc_clockevent_init
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-16-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the SoC relating codes in the function of
mxc_clockevent_init.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 29105ca..836d255 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -300,11 +300,8 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 static int __init mxc_clockevent_init(struct clk *timer_clk,
 		struct imx_timer *tm)
 {
-	if (timer_is_v2())
-		clockevent_mxc.set_next_event = v2_set_next_event;
-
-	clockevent_mxc.cpumask = cpumask_of(0);
-	clockevents_config_and_register(&clockevent_mxc,
+	tm->evt.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&tm->evt,
 					clk_get_rate(timer_clk),
 					0xff, 0xfffffffe);
 
-- 
1.9.1
