From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:58 +0200
Subject: [PATCH 12/17] ARM: exynos: cpuidle: Move S5P_CHECK_AFTR in a header
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the S5P_CHECK_AFTR definition to the header it belongs to.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c  |    2 --
 arch/arm/mach-exynos/regs-pmu.h |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 635b09c..839185e 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -38,8 +38,6 @@
 			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
 
-#define S5P_CHECK_AFTR		0xFCBA0D10
-
 #define EXYNOS5_PWR_CTRL1			(S5P_VA_CMU + 0x01020)
 #define EXYNOS5_PWR_CTRL2			(S5P_VA_CMU + 0x01024)
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 7c029ce..651014a 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -119,6 +119,7 @@
 #define S5P_INT_LOCAL_PWR_EN			0x7
 
 #define S5P_CHECK_SLEEP				0x00000BAD
+#define S5P_CHECK_AFTR				0xFCBA0D10
 
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	S5P_PMUREG(0x1154)
-- 
1.7.9.5
