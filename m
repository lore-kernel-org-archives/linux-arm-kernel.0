From: ta.omasab@gmail.com (Thomas Abraham)
Date: Thu,  9 Jan 2014 21:29:24 +0530
Subject: [PATCH 5/6] arm: exynos4-dt: statically add platform device for
 cpufreq-cpu0 platform driver
In-Reply-To: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1389283165-17708-6-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use the cpufreq-cpu0 driver on Exynos4 based platforms,
statically add the platform device for cpufreq-cpu0 platform driver.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos4-dt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index d3e54b7..8b8ad41 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -19,11 +19,17 @@
 
 #include "common.h"
 
+static struct platform_device cpufreq_device = {
+	.name		= "cpufreq-cpu0",
+	.id		= -1,
+};
+
 static void __init exynos4_dt_machine_init(void)
 {
 	exynos_cpuidle_init();
 	exynos_cpufreq_init();
 
+	platform_device_register(&cpufreq_device);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.6.6.rc2
