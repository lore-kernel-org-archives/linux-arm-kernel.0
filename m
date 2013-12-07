From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat,  7 Dec 2013 23:30:49 +0100
Subject: [PATCH v2] rtc: pxa: drop unused #define TIMER_FREQ
In-Reply-To: <87mwkc77d8.fsf@free.fr>
References: <87mwkc77d8.fsf@free.fr>
Message-ID: <1386455449-19678-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems this symbol was unused since the driver was introduced in
commit dc94436 (rtc: driver for pxa27x and pxa3xx SoC) back in 2009.

As a by-product this patch makes the driver stop "using" the symbol
CLOCK_TICK_RATE which is about to be removed very soon (for ARM).

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1, sent with
Message-id:1383942318-12569-1-git-send-email-u.kleine-koenig at pengutronix.de:

 - drop define instead of s/CLOCK_TICK_RATE/get_clock_tick_rate()/; thanks to
   Robert Jarzmik for pointing that out.

Note I intend to send this patch as part of a series that removes
<mach/timex.h> (and so CLOCK_TICK_RATE) on ARM. So dear maintainer please don't
take this patch but give your blessing that I can take it. (Note, I'm not sure
who's ack I need here; according to MAINTAINERS Alessandro Zummo maintains the
rtc subsystem, but he doesn't seem to be that active for some time and it's
mostly akpm who takes patches.)

 drivers/rtc/rtc-pxa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index a355f2b..cccbf9d 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -32,7 +32,6 @@
 
 #include <mach/hardware.h>
 
-#define TIMER_FREQ		CLOCK_TICK_RATE
 #define RTC_DEF_DIVIDER		(32768 - 1)
 #define RTC_DEF_TRIM		0
 #define MAXFREQ_PERIODIC	1000
-- 
1.8.4.3
