From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Tue, 26 Jul 2011 15:21:52 +0900
Subject: [PATCH] ARM: EXYNOS4: Change the pwm device name to supprot clkdev
Message-ID: <1311661312-24470-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/mach-exynos4/time.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/time.c b/arch/arm/mach-exynos4/time.c
index ebb8f38..9a74294 100644
--- a/arch/arm/mach-exynos4/time.c
+++ b/arch/arm/mach-exynos4/time.c
@@ -264,6 +264,7 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(timerclk);
 
 	tmpdev.id = 2;
+	tmpdev.dev.init_name = "s3c24xx-pwm.2";
 	tin2 = clk_get(&tmpdev.dev, "pwm-tin");
 	if (IS_ERR(tin2))
 		panic("failed to get pwm-tin2 clock for system timer");
@@ -274,6 +275,7 @@ static void __init exynos4_timer_resources(void)
 	clk_enable(tin2);
 
 	tmpdev.id = 4;
+	tmpdev.dev.init_name = "s3c24xx-pwm.4";
 	tin4 = clk_get(&tmpdev.dev, "pwm-tin");
 	if (IS_ERR(tin4))
 		panic("failed to get pwm-tin4 clock for system timer");
-- 
1.7.0
