From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 May 2017 16:05:39 +0200
Subject: [PATCH 5/8] clocksource/drivers/fttmr010: Switch to use bitops
In-Reply-To: <20170517140542.20016-1-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
Message-ID: <20170517140542.20016-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the drivers to use the bitops BIT() macro
to define bits.

Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/timer-fttmr010.c | 43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index 9ad31489bbef..9df14cf13808 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -16,6 +16,7 @@
 #include <linux/sched_clock.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/bitops.h>
 
 /*
  * Register definitions for the timers
@@ -36,31 +37,31 @@
 #define TIMER_INTR_STATE	(0x34)
 #define TIMER_INTR_MASK		(0x38)
 
-#define TIMER_1_CR_ENABLE	(1 << 0)
-#define TIMER_1_CR_CLOCK	(1 << 1)
-#define TIMER_1_CR_INT		(1 << 2)
-#define TIMER_2_CR_ENABLE	(1 << 3)
-#define TIMER_2_CR_CLOCK	(1 << 4)
-#define TIMER_2_CR_INT		(1 << 5)
-#define TIMER_3_CR_ENABLE	(1 << 6)
-#define TIMER_3_CR_CLOCK	(1 << 7)
-#define TIMER_3_CR_INT		(1 << 8)
-#define TIMER_1_CR_UPDOWN	(1 << 9)
-#define TIMER_2_CR_UPDOWN	(1 << 10)
-#define TIMER_3_CR_UPDOWN	(1 << 11)
+#define TIMER_1_CR_ENABLE	BIT(0)
+#define TIMER_1_CR_CLOCK	BIT(1)
+#define TIMER_1_CR_INT		BIT(2)
+#define TIMER_2_CR_ENABLE	BIT(3)
+#define TIMER_2_CR_CLOCK	BIT(4)
+#define TIMER_2_CR_INT		BIT(5)
+#define TIMER_3_CR_ENABLE	BIT(6)
+#define TIMER_3_CR_CLOCK	BIT(7)
+#define TIMER_3_CR_INT		BIT(8)
+#define TIMER_1_CR_UPDOWN	BIT(9)
+#define TIMER_2_CR_UPDOWN	BIT(10)
+#define TIMER_3_CR_UPDOWN	BIT(11)
 #define TIMER_DEFAULT_FLAGS	(TIMER_1_CR_UPDOWN | \
 				 TIMER_3_CR_ENABLE | \
 				 TIMER_3_CR_UPDOWN)
 
-#define TIMER_1_INT_MATCH1	(1 << 0)
-#define TIMER_1_INT_MATCH2	(1 << 1)
-#define TIMER_1_INT_OVERFLOW	(1 << 2)
-#define TIMER_2_INT_MATCH1	(1 << 3)
-#define TIMER_2_INT_MATCH2	(1 << 4)
-#define TIMER_2_INT_OVERFLOW	(1 << 5)
-#define TIMER_3_INT_MATCH1	(1 << 6)
-#define TIMER_3_INT_MATCH2	(1 << 7)
-#define TIMER_3_INT_OVERFLOW	(1 << 8)
+#define TIMER_1_INT_MATCH1	BIT(0)
+#define TIMER_1_INT_MATCH2	BIT(1)
+#define TIMER_1_INT_OVERFLOW	BIT(2)
+#define TIMER_2_INT_MATCH1	BIT(3)
+#define TIMER_2_INT_MATCH2	BIT(4)
+#define TIMER_2_INT_OVERFLOW	BIT(5)
+#define TIMER_3_INT_MATCH1	BIT(6)
+#define TIMER_3_INT_MATCH2	BIT(7)
+#define TIMER_3_INT_OVERFLOW	BIT(8)
 #define TIMER_INT_ALL_MASK	0x1ff
 
 struct fttmr010 {
-- 
2.9.3
