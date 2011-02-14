From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:00 +0900
Subject: [PATCH 04/11] ARM: EXYNOS4: Update Timer part
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates Timer part of EXYNOS4 according to the change of
ARCH name, EXYNOS4.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 .../include/mach/pwm-clock.h                       |    8 +-
 .../{mach-s5pv310 => mach-exynos4}/localtimer.c    |    2 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/time.c     |   64 ++++++++++----------
 3 files changed, 37 insertions(+), 37 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/include/mach/pwm-clock.h (90%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/localtimer.c (92%)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/time.c (78%)

diff --git a/arch/arm/mach-s5pv310/include/mach/pwm-clock.h b/arch/arm/mach-exynos4/include/mach/pwm-clock.h
similarity index 90%
rename from arch/arm/mach-s5pv310/include/mach/pwm-clock.h
rename to arch/arm/mach-exynos4/include/mach/pwm-clock.h
index 7e6da27..8e12090 100644
--- a/arch/arm/mach-s5pv310/include/mach/pwm-clock.h
+++ b/arch/arm/mach-exynos4/include/mach/pwm-clock.h
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5pv310/include/mach/pwm-clock.h
+/* linux/arch/arm/mach-exynos4/include/mach/pwm-clock.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
@@ -10,7 +10,7 @@
  *
  * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
  *
- * S5PV310 - pwm clock and timer support
+ * EXYNOS4 - pwm clock and timer support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-s5pv310/localtimer.c b/arch/arm/mach-exynos4/localtimer.c
similarity index 92%
rename from arch/arm/mach-s5pv310/localtimer.c
rename to arch/arm/mach-exynos4/localtimer.c
index 2784036..2a2993a 100644
--- a/arch/arm/mach-s5pv310/localtimer.c
+++ b/arch/arm/mach-exynos4/localtimer.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pv310/localtimer.c
+/* linux/arch/arm/mach-exynos4/localtimer.c
  *
  * Cloned from linux/arch/arm/mach-realview/localtimer.c
  *
diff --git a/arch/arm/mach-s5pv310/time.c b/arch/arm/mach-exynos4/time.c
similarity index 78%
rename from arch/arm/mach-s5pv310/time.c
rename to arch/arm/mach-exynos4/time.c
index b262d46..e30ac70 100644
--- a/arch/arm/mach-s5pv310/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv310/time.c
+/* linux/arch/arm/mach-exynos4/time.c
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * S5PV310 (and compatible) HRT support
+ * EXYNOS4 (and compatible) HRT support
  * PWM 2/4 is used for this feature
  *
  * This program is free software; you can redistribute it and/or modify
@@ -33,7 +33,7 @@ static struct clk *tdiv2;
 static struct clk *tdiv4;
 static struct clk *timerclk;
 
-static void s5pv310_pwm_stop(unsigned int pwm_id)
+static void exynos4_pwm_stop(unsigned int pwm_id)
 {
 	unsigned long tcon;
 
@@ -52,7 +52,7 @@ static void s5pv310_pwm_stop(unsigned int pwm_id)
 	__raw_writel(tcon, S3C2410_TCON);
 }
 
-static void s5pv310_pwm_init(unsigned int pwm_id, unsigned long tcnt)
+static void exynos4_pwm_init(unsigned int pwm_id, unsigned long tcnt)
 {
 	unsigned long tcon;
 
@@ -86,7 +86,7 @@ static void s5pv310_pwm_init(unsigned int pwm_id, unsigned long tcnt)
 	}
 }
 
-static inline void s5pv310_pwm_start(unsigned int pwm_id, bool periodic)
+static inline void exynos4_pwm_start(unsigned int pwm_id, bool periodic)
 {
 	unsigned long tcon;
 
@@ -117,23 +117,23 @@ static inline void s5pv310_pwm_start(unsigned int pwm_id, bool periodic)
 	__raw_writel(tcon, S3C2410_TCON);
 }
 
-static int s5pv310_pwm_set_next_event(unsigned long cycles,
+static int exynos4_pwm_set_next_event(unsigned long cycles,
 					struct clock_event_device *evt)
 {
-	s5pv310_pwm_init(2, cycles);
-	s5pv310_pwm_start(2, 0);
+	exynos4_pwm_init(2, cycles);
+	exynos4_pwm_start(2, 0);
 	return 0;
 }
 
-static void s5pv310_pwm_set_mode(enum clock_event_mode mode,
+static void exynos4_pwm_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
-	s5pv310_pwm_stop(2);
+	exynos4_pwm_stop(2);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		s5pv310_pwm_init(2, clock_count_per_tick);
-		s5pv310_pwm_start(2, 1);
+		exynos4_pwm_init(2, clock_count_per_tick);
+		exynos4_pwm_start(2, 1);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 		break;
@@ -149,11 +149,11 @@ static struct clock_event_device pwm_event_device = {
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.rating		= 200,
 	.shift		= 32,
-	.set_next_event	= s5pv310_pwm_set_next_event,
-	.set_mode	= s5pv310_pwm_set_mode,
+	.set_next_event	= exynos4_pwm_set_next_event,
+	.set_mode	= exynos4_pwm_set_mode,
 };
 
-irqreturn_t s5pv310_clock_event_isr(int irq, void *dev_id)
+irqreturn_t exynos4_clock_event_isr(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &pwm_event_device;
 
@@ -162,13 +162,13 @@ irqreturn_t s5pv310_clock_event_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction s5pv310_clock_event_irq = {
+static struct irqaction exynos4_clock_event_irq = {
 	.name		= "pwm_timer2_irq",
 	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= s5pv310_clock_event_isr,
+	.handler	= exynos4_clock_event_isr,
 };
 
-static void __init s5pv310_clockevent_init(void)
+static void __init exynos4_clockevent_init(void)
 {
 	unsigned long pclk;
 	unsigned long clock_rate;
@@ -198,10 +198,10 @@ static void __init s5pv310_clockevent_init(void)
 	pwm_event_device.cpumask = cpumask_of(0);
 	clockevents_register_device(&pwm_event_device);
 
-	setup_irq(IRQ_TIMER2, &s5pv310_clock_event_irq);
+	setup_irq(IRQ_TIMER2, &exynos4_clock_event_irq);
 }
 
-static cycle_t s5pv310_pwm4_read(struct clocksource *cs)
+static cycle_t exynos4_pwm4_read(struct clocksource *cs)
 {
 	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x40));
 }
@@ -209,12 +209,12 @@ static cycle_t s5pv310_pwm4_read(struct clocksource *cs)
 struct clocksource pwm_clocksource = {
 	.name		= "pwm_timer4",
 	.rating		= 250,
-	.read		= s5pv310_pwm4_read,
+	.read		= exynos4_pwm4_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
 };
 
-static void __init s5pv310_clocksource_init(void)
+static void __init exynos4_clocksource_init(void)
 {
 	unsigned long pclk;
 	unsigned long clock_rate;
@@ -226,14 +226,14 @@ static void __init s5pv310_clocksource_init(void)
 
 	clock_rate = clk_get_rate(tin4);
 
-	s5pv310_pwm_init(4, ~0);
-	s5pv310_pwm_start(4, 1);
+	exynos4_pwm_init(4, ~0);
+	exynos4_pwm_start(4, 1);
 
 	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
 		panic("%s: can't register clocksource\n", pwm_clocksource.name);
 }
 
-static void __init s5pv310_timer_resources(void)
+static void __init exynos4_timer_resources(void)
 {
 	struct platform_device tmpdev;
 
@@ -267,17 +267,17 @@ static void __init s5pv310_timer_resources(void)
 	clk_enable(tin4);
 }
 
-static void __init s5pv310_timer_init(void)
+static void __init exynos4_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
 	twd_base = S5P_VA_TWD;
 #endif
 
-	s5pv310_timer_resources();
-	s5pv310_clockevent_init();
-	s5pv310_clocksource_init();
+	exynos4_timer_resources();
+	exynos4_clockevent_init();
+	exynos4_clocksource_init();
 }
 
-struct sys_timer s5pv310_timer = {
-	.init		= s5pv310_timer_init,
+struct sys_timer exynos4_timer = {
+	.init		= exynos4_timer_init,
 };
-- 
1.7.1
