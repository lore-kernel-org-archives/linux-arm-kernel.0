From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Tue, 23 Aug 2016 23:19:29 +0800
Subject: [PATCH v4] clocksource/drivers/pxa: fix include files for compilation
Message-ID: <1471965569-4104-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning about global functions without a declaration in the
 clocksource/drivers/pxa driver when building with W=1:

drivers/clocksource/pxa_timer.c:221:13: warning: no previous prototype for 'pxa_timer_nodt_init' [-Wmissing-prototypes]
 void __init pxa_timer_nodt_init(int irq, void __iomem *base,

In fact, this function is declared in pxa.h, so this patch
add missing header dependencies.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/pxa_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 937e10b..3e1cb51 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -21,6 +21,8 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#include <clocksource/pxa.h>
+
 #include <asm/div64.h>
 
 #define OSMR0		0x00	/* OS Timer 0 Match Register */
-- 
2.7.4
