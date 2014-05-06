From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  6 May 2014 22:42:29 +0800
Subject: [PATCH] clocksource: prima2: fix some minor checkpatch issues
Message-ID: <1399387349-19346-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

Fix the "line over 80 characters". users of the codes - key customers
really care about that.

WARNING: line over 80 characters
64: FILE: timer-prima2.c:64:
+       WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) & BIT(0)));

WARNING: line over 80 characters
80: FILE: timer-prima2.c:80:
+       writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);

WARNING: line over 80 characters
82: FILE: timer-prima2.c:82:
+       cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);

WARNING: line over 80 characters
92: FILE: timer-prima2.c:92:
+       writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);

WARNING: line over 80 characters
96: FILE: timer-prima2.c:96:
+       writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);

WARNING: line over 80 characters
111: FILE: timer-prima2.c:111:
+               writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);

WARNING: line over 80 characters
114: FILE: timer-prima2.c:114:
+               writel_relaxed(val & ~BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);

WARNING: line over 80 characters
126: FILE: timer-prima2.c:126:
+       writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);

WARNING: line over 80 characters
129: FILE: timer-prima2.c:129:
+               sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);

WARNING: line over 80 characters
137: FILE: timer-prima2.c:137:
+               writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);

WARNING: line over 80 characters
139: FILE: timer-prima2.c:139:
+       writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);

WARNING: line over 80 characters
140: FILE: timer-prima2.c:140:
+       writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);

WARNING: line over 80 characters
216: FILE: timer-prima2.c:216:
+CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer, "sirf,prima2-tick", sirfsoc_prima2_timer_init);

total: 0 errors, 13 warnings, 216 lines checked

timer-prima2.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clocksource/timer-prima2.c |   42 ++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index 19bc0a9..a722aac 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -61,7 +61,8 @@ static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ce = dev_id;
 
-	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) & BIT(0)));
+	WARN_ON(!(readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_STATUS) &
+		BIT(0)));
 
 	/* clear timer0 interrupt */
 	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
@@ -77,9 +78,11 @@ static cycle_t sirfsoc_timer_read(struct clocksource *cs)
 	u64 cycles;
 
 	/* latch the 64-bit timer counter */
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
+		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
 	cycles = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_HI);
-	cycles = (cycles << 32) | readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
+	cycles = (cycles << 32) |
+		readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
 
 	return cycles;
 }
@@ -89,11 +92,13 @@ static int sirfsoc_timer_set_next_event(unsigned long delta,
 {
 	unsigned long now, next;
 
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
+		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
 	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
 	next = now + delta;
 	writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
+		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
 	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
 
 	return next - now > delta ? -ETIME : 0;
@@ -108,10 +113,12 @@ static void sirfsoc_timer_set_mode(enum clock_event_mode mode,
 		WARN_ON(1);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
-		writel_relaxed(val | BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+		writel_relaxed(val | BIT(0),
+			sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
 		break;
 	case CLOCK_EVT_MODE_SHUTDOWN:
-		writel_relaxed(val & ~BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
+		writel_relaxed(val & ~BIT(0),
+			sirfsoc_timer_base + SIRFSOC_TIMER_INT_EN);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_RESUME:
@@ -123,10 +130,13 @@ static void sirfsoc_clocksource_suspend(struct clocksource *cs)
 {
 	int i;
 
-	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
+	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT,
+		sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
 
 	for (i = 0; i < SIRFSOC_TIMER_REG_CNT; i++)
-		sirfsoc_timer_reg_val[i] = readl_relaxed(sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+		sirfsoc_timer_reg_val[i] =
+			readl_relaxed(sirfsoc_timer_base +
+				sirfsoc_timer_reg_list[i]);
 }
 
 static void sirfsoc_clocksource_resume(struct clocksource *cs)
@@ -134,10 +144,13 @@ static void sirfsoc_clocksource_resume(struct clocksource *cs)
 	int i;
 
 	for (i = 0; i < SIRFSOC_TIMER_REG_CNT - 2; i++)
-		writel_relaxed(sirfsoc_timer_reg_val[i], sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
+		writel_relaxed(sirfsoc_timer_reg_val[i],
+			sirfsoc_timer_base + sirfsoc_timer_reg_list[i]);
 
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
-	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1], sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 2],
+		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
+	writel_relaxed(sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT - 1],
+		sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 }
 
 static struct clock_event_device sirfsoc_clockevent = {
@@ -199,7 +212,7 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 
 	writel_relaxed(rate / PRIMA2_CLOCK_FREQ / 2 - 1,
-		       sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
+		sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_HI);
 	writel_relaxed(BIT(0), sirfsoc_timer_base + SIRFSOC_TIMER_STATUS);
@@ -213,4 +226,5 @@ static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	sirfsoc_clockevent_init();
 }
-CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer, "sirf,prima2-tick", sirfsoc_prima2_timer_init);
+CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer,
+	"sirf,prima2-tick", sirfsoc_prima2_timer_init);
-- 
1.7.5.4
