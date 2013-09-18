From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 18 Sep 2013 11:48:36 -0700
Subject: [PATCH v2 2/4] clocksource/arm_global_timer: Set FEAT_PERCPU flag
In-Reply-To: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379530118-22813-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm_global_timer is a per cpu device. Set the appropriate flag.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/arm_global_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index b66c1f3..c639b1a 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -169,7 +169,8 @@ static int gt_clockevents_init(struct clock_event_device *clk)
 	int cpu = smp_processor_id();
 
 	clk->name = "arm_global_timer";
-	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+		CLOCK_EVT_FEAT_PERCPU;
 	clk->set_mode = gt_clockevent_set_mode;
 	clk->set_next_event = gt_clockevent_set_next_event;
 	clk->cpumask = cpumask_of(cpu);
-- 
1.8.4
