From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:30:40 +0530
Subject: [PATCH 094/228] cpufreq: blackfin: don't initialize part of policy
 that is set by core too
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <26f6beb862d15b9c763f0a71737a8d3bb255ffab.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 48888cf..0bc9e8c 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -204,7 +204,6 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = 50000; /* 50us assumed */
 
-	policy->cur = cclk;
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
-- 
1.7.12.rc2.18.g61b472e
