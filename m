From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 May 2013 12:26:13 -0700
Subject: [PATCHv6 09/11] clocksource: time-armada-370-xp: Fix sparse warning
In-Reply-To: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1368473175-4841-10-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/clocksource/time-armada-370-xp.c:217:13: warning: symbol
'armada_370_xp_timer_init' was not declared. Should it be static?

Also remove the __init marking in the prototype as it's
unnecessary and drop the init.h file.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clocksource/time-armada-370-xp.c | 3 ++-
 include/linux/time-armada-370-xp.h       | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 47a6730..efe4aef 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -27,10 +27,11 @@
 #include <linux/of_address.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/time-armada-370-xp.h>
 
 #include <asm/sched_clock.h>
 #include <asm/localtimer.h>
-#include <linux/percpu.h>
 /*
  * Timer block registers.
  */
diff --git a/include/linux/time-armada-370-xp.h b/include/linux/time-armada-370-xp.h
index dfdfdc0..6fb0856 100644
--- a/include/linux/time-armada-370-xp.h
+++ b/include/linux/time-armada-370-xp.h
@@ -11,8 +11,6 @@
 #ifndef __TIME_ARMADA_370_XPPRCMU_H
 #define __TIME_ARMADA_370_XPPRCMU_H
 
-#include <linux/init.h>
-
-void __init armada_370_xp_timer_init(void);
+void armada_370_xp_timer_init(void);
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
