From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Nov 2013 21:25:18 +0100
Subject: [PATCH] rtc: pxa: drop usage of CLOCK_TICK_RATE
Message-ID: <1383942318-12569-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol CLOCK_TICK_RATE is (at least on ARM) defined in an platform
specific header <mach/timex.h>. There are plans to stop using and kill
these platform specific headers. So fix the only user of pxa's
<mach/timex.h> to not use it.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
It would be nice to use the clk API to find the tick rate, but I didn't
find any clk to use.
---
 drivers/rtc/rtc-pxa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index a355f2b..0ba07e1 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -32,7 +32,7 @@
 
 #include <mach/hardware.h>
 
-#define TIMER_FREQ		CLOCK_TICK_RATE
+#define TIMER_FREQ		get_clock_tick_rate()
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define MAXFREQ_PERIODIC	1000
-- 
1.7.10.4
