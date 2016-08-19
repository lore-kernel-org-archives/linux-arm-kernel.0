From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 19 Aug 2016 11:43:12 -0400
Subject: [PATCH v3 1/2] ARM: exynos_defconfig: Don't attempt to enable
 schedutil governor as module
Message-ID: <1471621393-20382-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The schedutil CPUFreq governor could be built as a module but the commit
58919e83c85c ("cpufreq / sched: Pass flags to cpufreq_update_util()")
made it non-modular so attempting to enable as module leads to a warning:

warning: symbol value 'm' invalid for CPU_FREQ_GOV_SCHEDUTIL

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes in v3:
- Add Krzysztof Kozlowski's Reviewed-by tag.

Changes in v2:
- Include linux-samsung-soc ML to cc list. Suggested by Krzysztof Kozlowski.

 arch/arm/configs/exynos_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 5476be3be686..4e484f406419 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -29,7 +29,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
-CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
-- 
2.5.5
