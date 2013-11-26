From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Nov 2013 19:48:11 +0100
Subject: [PATCH 6/4] ARM: ixp4xx: stop using <mach/timex.h>
In-Reply-To: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1385491691-26002-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only user of symbols defined in ixp4xx's <mach/timex.h> is common.c.
Fix that one up by moving the used #define into common.c directly. This
makes ixp4xx not to be a bar to dropping support for <mach/timex.h>.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Hello,

Similar to the ixp4xx-beeper patch I target to take this one as part of a pull
request to drop <mach/timex.h>. So dear maintainers, I'd prefer you to give
your ack to allow me to forward this patch to the arm-soc people instead of you
taking it directly.

Thanks
Uwe

 arch/arm/mach-ixp4xx/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 9edaf47..967ddc2 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/time.h>
-#include <linux/timex.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/io.h>
@@ -45,6 +44,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#define IXP4XX_TIMER_FREQ 66666000
+
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
-- 
1.8.4.2
