From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 02 Jun 2011 18:30:52 +0900
Subject: [PATCH] ARM: exynos4: remove compiler warning:	'exynos4_pwm4_resume'
Message-ID: <20110602093052.GA16756@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Remove compiler warning when no CONFIG_PM

arch/arm/mach-exynos4/time.c:209: warning: 'exynos4_pwm4_resume' defined but not used

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index 86b9fa0..ebb8f38 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -206,6 +206,7 @@ static cycle_t exynos4_pwm4_read(struct clocksource *cs)
 	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x40));
 }
 
+#ifdef CONFIG_PM
 static void exynos4_pwm4_resume(struct clocksource *cs)
 {
 	unsigned long pclk;
@@ -218,6 +219,7 @@ static void exynos4_pwm4_resume(struct clocksource *cs)
 	exynos4_pwm_init(4, ~0);
 	exynos4_pwm_start(4, 1);
 }
+#endif
 
 struct clocksource pwm_clocksource = {
 	.name		= "pwm_timer4",
