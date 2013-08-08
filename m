From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  8 Aug 2013 19:18:10 +0530
Subject: [PATCH 08/35] cpufreq: cpufreq-cpu0: use
 cpufreq_table_validate_and_show()
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ad1fde2..65d70a3 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -128,7 +128,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
 		pr_err("invalid frequency table: %d\n", ret);
 		return ret;
@@ -144,8 +144,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	cpumask_setall(policy->cpus);
 
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e
