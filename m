From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Sep 2013 13:13:12 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Use clocksource for suspend
 timekeeping
Message-ID: <1380312792-7275-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timers keep counting during suspend so we can
mark this clocksource with the CLOCK_SOURCE_SUSPEND_NONSTOP flag.
This flag will indicate that this clocksource can be used for
calculating suspend time and injecting sleep time into the
timekeeping core. This should be more accurate than using an
external RTC or architecture specific persistent clock.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fbd9ccd..ce98d5e 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -389,7 +389,7 @@ static struct clocksource clocksource_counter = {
 	.rating	= 400,
 	.read	= arch_counter_read,
 	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
 static struct cyclecounter cyclecounter = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
