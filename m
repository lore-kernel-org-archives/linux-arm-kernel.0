From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  8 Aug 2013 19:18:14 +0530
Subject: [PATCH 12/35] cpufreq: e_powersaver: use
 cpufreq_table_validate_and_show()
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <557aa7077de100ce67198fa36973b37703aa37c6.1375964117.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/e_powersaver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 09f64cc..c1b7c99 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -403,13 +403,12 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 140000; /* 844mV -> 700mV in ns */
 	policy->cur = fsb * current_multiplier;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, &centaur->freq_table[0]);
+	ret = cpufreq_table_validate_and_show(policy, &centaur->freq_table[0]);
 	if (ret) {
 		kfree(centaur);
 		return ret;
 	}
 
-	cpufreq_frequency_table_get_attr(&centaur->freq_table[0], policy->cpu);
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e
