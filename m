From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  8 Aug 2013 19:18:25 +0530
Subject: [PATCH 23/35] cpufreq: pasemi: use cpufreq_table_validate_and_show()
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <b8ba08315a80d680f71bfe7cdde8d1c7b39f875b.1375964117.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 534e43a..23bc8a82 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -219,12 +219,10 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	ppc_proc_freq = policy->cur * 1000ul;
 
-	cpufreq_frequency_table_get_attr(pas_freqs, policy->cpu);
-
 	/* this ensures that policy->cpuinfo_min and policy->cpuinfo_max
 	 * are set correctly
 	 */
-	return cpufreq_frequency_table_cpuinfo(policy, pas_freqs);
+	return cpufreq_table_validate_and_show(policy, pas_freqs);
 
 out_unmap_sdcpwr:
 	iounmap(sdcpwr_mapbase);
-- 
1.7.12.rc2.18.g61b472e
