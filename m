From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon,  2 Feb 2015 16:58:07 -0400
Subject: [PATCH 04/14] cpufreq: exynos4x12: properly put of node
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Message-ID: <1422910697-5920-5-git-send-email-edubezval@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call of_node_put when necessary during init.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4x12-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 9e78a85..3d067f2 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -221,6 +221,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	info->set_freq = exynos4x12_set_frequency;
 
 	cpufreq = info;
+	of_node_put(np);
 
 	return 0;
 
@@ -231,6 +232,8 @@ err_mout_mpll:
 err_moutcore:
 	clk_put(cpu_clk);
 
+	of_node_put(np);
 	pr_debug("%s: failed initialization\n", __func__);
+
 	return -EINVAL;
 }
-- 
2.1.3
