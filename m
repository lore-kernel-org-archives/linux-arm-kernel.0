From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Apr 2013 17:27:41 -0700
Subject: [PATCHv2 2/4] ARM: arch_timers: Pass clock event to set_mode callback
In-Reply-To: <1365812863-5367-1-git-send-email-sboyd@codeaurora.org>
References: <1365812863-5367-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1365812863-5367-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There isn't any reason why we don't pass the event here and we'll
need it in the near future for memory mapped arch timers anyway.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 2abb861..545891b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -140,7 +140,7 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 
 	clk->cpumask = cpumask_of(smp_processor_id());
 
-	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, NULL);
+	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, clk);
 
 	clockevents_config_and_register(clk, arch_timer_rate,
 					0xf, 0x7fffffff);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
