From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Nov 2013 22:41:06 +0100
Subject: [PATCH 4/4] ARM: ep93xx: stop using mach/timex.h
In-Reply-To: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1384292466-31725-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is the last remaining header that is unused for multiarch
builds but necessary for singlearch builds. To allow to get rid of it
for singlearch builds, too, drop its usage in ep93xx arch code by
substituting CLOCK_TICK_RATE by a local cpp symbol.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-ep93xx/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 157ba88..615244b 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -116,8 +116,9 @@ void __init ep93xx_map_io(void)
 #define EP93XX_TIMER123_CLOCK		508469
 #define EP93XX_TIMER4_CLOCK		983040
 
+#define EP93XX_CLOCK_FREQ		983040
 #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
-#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
+#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_CLOCK_FREQ, HZ)
 
 static unsigned int last_jiffy_time;
 
-- 
1.8.4.2
