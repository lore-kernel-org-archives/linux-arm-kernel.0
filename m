From: arjun024@gmail.com (Arjun Sreedharan)
Date: Sun, 17 Aug 2014 09:36:14 +0530
Subject: [PATCH] cpufreq: exynos: free memory immediately on unknown SoC
Message-ID: <1408248374-1638-1-git-send-email-arjun024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 1e0ec57..e47d165 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -178,6 +178,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
 		pr_err("%s: Unknown SoC type\n", __func__);
+		kfree(exynos_info);
 		return -ENODEV;
 	}
 
-- 
1.7.11.7
