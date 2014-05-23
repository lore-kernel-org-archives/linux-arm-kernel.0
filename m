From: thomas.ab@samsung.com (Thomas Abraham)
Date: Fri, 23 May 2014 19:57:39 +0530
Subject: [PATCH v5 6/7] ARM: Exynos: switch to using generic cpufreq-cpu0
 driver
In-Reply-To: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
References: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1400855260-6807-7-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Remove the platform device instantiation for Exynos specific cpufreq
driver and add the platform device for cpufreq-cpu0 driver.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 93507ee..2193061 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -184,7 +184,9 @@ void __init exynos_cpuidle_init(void)
 
 void __init exynos_cpufreq_init(void)
 {
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+	if (!(of_machine_is_compatible("samsung,exynos5420")) &&
+		!(of_machine_is_compatible("samsung,exynos5440")))
+		platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 void __init exynos_init_late(void)
-- 
1.7.9.5
