From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 30 Mar 2016 13:45:27 +0530
Subject: [PATCH V3 3/4] ARM: exynos: exynos-cpufreq platform device isn't
 supported anymore
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Message-ID: <abff8b995fce34ea80c68c5d11ccb8a525fb81fa.1459325515.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver is removed long back and we don't support this device
anymore. Stop adding it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a46f772..4dfce1069406 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -232,12 +232,8 @@ static void __init exynos_cpufreq_init(void)
 	const struct of_device_id *match;
 
 	match = of_match_node(exynos_cpufreq_matches, root);
-	if (!match) {
-		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-		return;
-	}
-
-	platform_device_register_simple(match->data, -1, NULL, 0);
+	if (match)
+		platform_device_register_simple(match->data, -1, NULL, 0);
 }
 
 static void __init exynos_dt_machine_init(void)
-- 
2.7.1.410.g6faf27b
