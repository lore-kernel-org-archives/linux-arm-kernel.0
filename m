From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 26 May 2013 15:12:46 +0300
Subject: [PATCH 1/2] clocksource: dw_apb: remove unused header
Message-ID: <1369570367-994-1-git-send-email-baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The time.h header seems not to be used by current code. Removing this include
allows the driver to build on other architecture that do not have this header.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Dinh Nguyen <dinguyen@altera.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/clocksource/dw_apb_timer_of.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
index ab09ed3..5a61ebc 100644
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@ -21,7 +21,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
 static void timer_get_base_and_rate(struct device_node *np,
-- 
1.7.10.4
