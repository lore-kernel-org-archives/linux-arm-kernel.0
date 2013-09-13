From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:29:43 +0530
Subject: [PATCH 037/228] cpufreq: s5pv210: use
 cpufreq_table_validate_and_show()
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <d7c1d454ed9530886d7aed5a2871b96919cb2446.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5c77570..c266a7e 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -553,11 +553,9 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = s5pv210_getspeed(0);
 
-	cpufreq_frequency_table_get_attr(s5pv210_freq_table, policy->cpu);
-
 	policy->cpuinfo.transition_latency = 40000;
 
-	return cpufreq_frequency_table_cpuinfo(policy, s5pv210_freq_table);
+	return cpufreq_table_validate_and_show(policy, s5pv210_freq_table);
 
 out_dmc1:
 	clk_put(dmc0_clk);
-- 
1.7.12.rc2.18.g61b472e
