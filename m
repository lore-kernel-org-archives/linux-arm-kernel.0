From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:12 +0200
Subject: [PATCH V5 17/20] ARM: exynos: cpuidle: Move S5P_CHECK_SLEEP into pm.c
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-18-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This macro is only used there.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/pm.c       |    3 ++-
 arch/arm/mach-exynos/regs-pmu.h |    2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 6d9ef69..b380d48 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -108,7 +108,8 @@ static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
 
-#define S5P_CHECK_AFTR 0xFCBA0D10
+#define S5P_CHECK_AFTR  0xFCBA0D10
+#define S5P_CHECK_SLEEP 0x00000BAD
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
 static void exynos_set_wakeupmask(long mask)
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 4f6a256..6c1d2db 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -119,8 +119,6 @@
 #define S5P_CORE_LOCAL_PWR_EN			0x3
 #define S5P_INT_LOCAL_PWR_EN			0x7
 
-#define S5P_CHECK_SLEEP				0x00000BAD
-
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	S5P_PMUREG(0x1154)
 #define S5P_CMU_RESET_LCD1_LOWPWR	S5P_PMUREG(0x1174)
-- 
1.7.9.5
