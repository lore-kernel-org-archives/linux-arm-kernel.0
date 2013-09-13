From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:23 +0530
Subject: [PATCH 137/228] cpufreq: maple: use cpufreq_generic_init() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <72a62d6c0deb04eb0262ebc9bc52b6a3735d7466.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index 1c0cec1..eb1e176 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -165,16 +165,9 @@ static unsigned int maple_cpufreq_get_speed(unsigned int cpu)
 
 static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	policy->cpuinfo.transition_latency = 12000;
-	/* secondary CPUs are tied to the primary one by the
-	 * cpufreq core if in the secondary policy we tell it that
-	 * it actually must be one policy together with all others. */
-	cpumask_setall(policy->cpus);
-
-	return cpufreq_table_validate_and_show(policy, maple_cpu_freqs);
+	return cpufreq_generic_init(policy, maple_cpu_freqs, 12000);
 }
 
-
 static struct cpufreq_driver maple_cpufreq_driver = {
 	.name		= "maple",
 	.flags		= CPUFREQ_CONST_LOOPS,
-- 
1.7.12.rc2.18.g61b472e
