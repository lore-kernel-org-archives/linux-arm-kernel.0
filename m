From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  8 Aug 2013 19:18:35 +0530
Subject: [PATCH 33/35] cpufreq: spear: use cpufreq_table_validate_and_show()
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <6d43bbdce2e7d6dfcd6cd8296722d40feddcf2f2.1375964117.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: spear-devel at list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index c3efa7f..1d619dd 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -178,13 +178,12 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, spear_cpufreq.freq_tbl);
+	ret = cpufreq_table_validate_and_show(policy, spear_cpufreq.freq_tbl);
 	if (ret) {
-		pr_err("cpufreq_frequency_table_cpuinfo() failed");
+		pr_err("cpufreq_table_validate_and_show() failed");
 		return ret;
 	}
 
-	cpufreq_frequency_table_get_attr(spear_cpufreq.freq_tbl, policy->cpu);
 	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
 	policy->cur = spear_cpufreq_get(0);
 
-- 
1.7.12.rc2.18.g61b472e
