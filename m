From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:02 +0530
Subject: [PATCH 116/228] cpufreq: ppc: don't initialize part of policy that is
 set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <bb32c408741e1008c39ce62ec03bc76e5ccaa267.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index befd489..a0f562c 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -217,8 +217,6 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		per_cpu(cpu_data, i) = data;
 
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	policy->cur = corenet_cpufreq_get_speed(policy->cpu);
-
 	of_node_put(np);
 
 	return 0;
-- 
1.7.12.rc2.18.g61b472e
