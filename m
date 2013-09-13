From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:54 +0530
Subject: [PATCH 108/228] cpufreq: longhaul: don't initialize part of policy
 that is set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <931996f14c59f67a8945fafd95967f0be93776ba.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/longhaul.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 57d7b02..14df497 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -913,7 +913,6 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 		longhaul_setup_voltagescaling();
 
 	policy->cpuinfo.transition_latency = 200000;	/* nsec */
-	policy->cur = calc_speed(longhaul_get_cpu_mult());
 
 	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
-- 
1.7.12.rc2.18.g61b472e
