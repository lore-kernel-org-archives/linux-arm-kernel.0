From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:44 +0200
Subject: [PATCH 64/71] clocksource: dw_apb_timer_of: Do not trace
 read_sched_clock
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-64-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Wei <Wei.Yang@windriver.com>

We do not need to trace read_sched_clock function,
so add notrace attribute for this function.

Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/dw_apb_timer_of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index 2a2ea27..d305fb0 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -106,7 +106,7 @@ static void __init add_clocksource(struct device_node *source_timer)
 	sched_rate = rate;
 }
 
-static u64 read_sched_clock(void)
+static u64 notrace read_sched_clock(void)
 {
 	return ~__raw_readl(sched_io_base);
 }
-- 
1.7.9.5
