From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2018 23:16:07 +0200
Subject: [PATCH 2/3] clocksource/driver/ep93xx: Fix up includes
In-Reply-To: <20180930211608.5516-1-linus.walleij@linaro.org>
References: <20180930211608.5516-1-linus.walleij@linaro.org>
Message-ID: <20180930211608.5516-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the right interfaces for use with this driver.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource: please ACK this if OK so I can merge this
patch through the ARM SoC tree.
---
 drivers/clocksource/timer-ep93xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
index 9b5e98446d77..3dcc58de65ef 100644
--- a/drivers/clocksource/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/sched_clock.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/platform_data/timer-ep93xx.h>
-#include <asm/mach/time.h>
+#include <linux/slab.h>
 
 static void __iomem *ep93xx_base;
 
-- 
2.17.1
