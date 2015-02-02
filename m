From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon,  2 Feb 2015 16:58:14 -0400
Subject: [PATCH 11/14] cpufreq: exynos4210: remove unused symbol cpufreq
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Message-ID: <1422910697-5920-12-git-send-email-edubezval@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the set_freq call back receives the intended
data struct, the global cpufreq variable may be removed.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4210-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 00889a4..6757bda 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -25,7 +25,6 @@ static struct clk *cpu_clk;
 static struct clk *moutcore;
 static struct clk *mout_mpll;
 static struct clk *mout_apll;
-static struct exynos_dvfs_info *cpufreq;
 
 static unsigned int exynos4210_volt_table[] = {
 	1250000, 1150000, 1050000, 975000, 950000,
@@ -171,7 +170,6 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 	info->freq_table = exynos4210_freq_table;
 	info->set_freq = exynos4210_set_frequency;
 
-	cpufreq = info;
 	of_node_put(np);
 
 	return 0;
-- 
2.1.3
