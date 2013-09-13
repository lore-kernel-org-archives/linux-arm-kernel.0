From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:29 +0530
Subject: [PATCH 143/228] cpufreq: s5pv210: use cpufreq_generic_init() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <9223cc644b2a73df35e228dd5a815d949988ccdd.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 30d9bb7..600b4f4 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -543,9 +543,7 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	s5pv210_dram_conf[1].refresh = (__raw_readl(S5P_VA_DMC1 + 0x30) * 1000);
 	s5pv210_dram_conf[1].freq = clk_get_rate(dmc1_clk);
 
-	policy->cpuinfo.transition_latency = 40000;
-
-	return cpufreq_table_validate_and_show(policy, s5pv210_freq_table);
+	return cpufreq_generic_init(policy, s5pv210_freq_table, 40000);
 
 out_dmc1:
 	clk_put(dmc0_clk);
-- 
1.7.12.rc2.18.g61b472e
