From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Jan 2013 17:59:57 +0100
Subject: [PATCH 3/5] ARM: exynos: replace cpumask by the corresponding macro
In-Reply-To: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
References: <1357318799-24378-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1357318799-24378-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A trivial patch to replace for_each_cpu(cpu_id, cpu_online_mask) by
the corresponding macro.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index a5fe194..6e90bed 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -205,7 +205,7 @@ static int __init exynos4_init_cpuidle(void)
 		return ret;
 	}
 
-	for_each_cpu(cpu_id, cpu_online_mask) {
+	for_each_online_cpu(cpu_id) {
 		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
 		device->cpu = cpu_id;
 
-- 
1.7.9.5
