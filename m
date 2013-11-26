From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Nov 2013 14:29:26 +0100
Subject: [PATCH v2 4/4] ARM: ep93xx: stop using mach/timex.h
In-Reply-To: <1384292466-31725-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1385472566-20950-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is the last remaining header that is unused for multiarch
builds but necessary for singlearch builds. To allow to get rid of it
for singlearch builds, too, drop its usage in ep93xx arch code by
substituting CLOCK_TICK_RATE by an already defined local cpp symbol.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
Changes since (implicit) v1, sent with
Message-Id: 1384292466-31725-5-git-send-email-u.kleine-koenig at pengutronix.de:
 - ack by H Hartley Sweeten
 - use already existing symbol instead of introducing a new one

 arch/arm/mach-ep93xx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index d95ee28a..94b141f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -115,7 +115,7 @@ void __init ep93xx_map_io(void)
 #define EP93XX_TIMER4_CLOCK		983040
 
 #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
+#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
 
 static unsigned int last_jiffy_time;
 
-- 
1.8.4.2
