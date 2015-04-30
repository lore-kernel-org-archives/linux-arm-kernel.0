From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:19 -0500
Subject: [PATCH 04/18] ARM: imx: Added one more parameter for
 mxc_clockevent_init
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-5-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more parameter was added for the function of
mxc_clockevent_init, so that we could remove the
global variables later.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index f44c2aa..f7403ab 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -299,7 +299,8 @@ static struct clock_event_device clockevent_mxc = {
 	.rating		= 200,
 };
 
-static int __init mxc_clockevent_init(struct clk *timer_clk)
+static int __init mxc_clockevent_init(struct clk *timer_clk,
+		struct imx_timer *tm)
 {
 	if (timer_is_v2())
 		clockevent_mxc.set_next_event = v2_set_next_event;
@@ -355,7 +356,7 @@ static void __init _mxc_timer_init(int irq,
 
 	/* init and register the timer to the framework */
 	mxc_clocksource_init(clk_per);
-	mxc_clockevent_init(clk_per);
+	mxc_clockevent_init(clk_per, 0);
 
 	/* Make irqs happen */
 	setup_irq(irq, &mxc_timer_irq);
-- 
1.9.1
