From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Jun 2015 09:01:31 +0200
Subject: [PATCH] ARM: ep93xx: update comment on timer usage
Message-ID: <1434438091-9475-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When refactoring the EP93xx timer some of the documentation
git out of date. Update it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ep93xx/timer-ep93xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
index 9edaa754b689..ac48ac1fd16d 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
@@ -18,15 +18,14 @@
  * is free-running, and can't generate interrupts.
  *
  * The 508 kHz timers are ideal for use for the timer interrupt, as the
- * most common values of HZ divide 508 kHz nicely.  We pick one of the 16
- * bit timers (timer 1) since we don't need more than 16 bits of reload
- * value as long as HZ >= 8.
+ * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
+ * timer (timer 3) to get as long sleep intervals as possible when using
+ * CONFIG_NO_HZ.
  *
  * The higher clock rate of timer 4 makes it a better choice than the
- * other timers for use in gettimeoffset(), while the fact that it can't
- * generate interrupts means we don't have to worry about not being able
- * to use this timer for something else.  We also use timer 4 for keeping
- * track of lost jiffies.
+ * other timers for use as clock source and for sched_clock(), providing
+ * a stable 40 bit time base.
+ *************************************************************************
  */
 #define EP93XX_TIMER_REG(x)		(EP93XX_TIMER_BASE + (x))
 #define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
-- 
1.9.3
