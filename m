From: rabin@rab.in (Rabin Vincent)
Date: Fri, 19 Nov 2010 21:36:24 +0530
Subject: [PATCH] ARM: u300: ensure sched_clock() is notrace
Message-ID: <1290182785-22352-3-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include sched.h to ensure sched_clock() has the notrace
annotation, and mark any functions it calls as notrace
too.

Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/mach-u300/timer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 3fc4472..776bdf3 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/sched.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/types.h>
@@ -332,7 +333,7 @@ static struct irqaction u300_timer_irq = {
 };
 
 /* Use general purpose timer 2 as clock source */
-static cycle_t u300_get_cycles(struct clocksource *cs)
+static cycle_t notrace u300_get_cycles(struct clocksource *cs)
 {
 	return (cycles_t) readl(U300_TIMER_APP_VBASE + U300_TIMER_APP_GPT2CC);
 }
-- 
1.7.2.3
