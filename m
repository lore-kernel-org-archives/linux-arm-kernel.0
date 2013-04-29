From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Apr 2013 18:54:48 +0530
Subject: [PATCH 5/5] cpufreq: ARM big LITTLE: Improve print message
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Message-ID: <61da22c0f40fb46dc31f0ad5183b4ea51dda518c.1367241503.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print message at the end of driver->init() doesn't carry "cpufreq" string at all
and so is difficult to find in dmesg. Add function name in message to clearly
state where the message is coming from.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index fd7beed..5d7f53f 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -187,7 +187,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 
 	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
-	dev_info(cpu_dev, "CPU %d initialized\n", policy->cpu);
+	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e
