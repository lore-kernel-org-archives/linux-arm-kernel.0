From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:58 +0530
Subject: [PATCH 112/228] cpufreq: p4: don't initialize part of policy that is
 set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <bb01f4097f78c027a078feba6e54c2b8d2daaf33.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/p4-clockmod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 4fe6d4c..6164c1c 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -230,7 +230,6 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 	/* the transition latency is set to be 1 higher than the maximum
 	 * transition latency of the ondemand governor */
 	policy->cpuinfo.transition_latency = 10000001;
-	policy->cur = stock_freq;
 
 	return cpufreq_table_validate_and_show(policy, &p4clockmod_table[0]);
 }
-- 
1.7.12.rc2.18.g61b472e
