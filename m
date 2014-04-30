From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Wed, 30 Apr 2014 15:28:36 +0900
Subject: [PATCH 3/3] cpufreq: Pass third argument as function parameter is
Message-ID: <000201cf643d$6ac0da00$40428e00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In dev_pm_opp_init_cpufreq_table, flags parameter is added to
indicate descending order. If flags is zero, it is a ascending
order.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/arm_big_little.c |    2 +-
 drivers/cpufreq/cpufreq-cpu0.c   |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c  |    2 +-
 drivers/cpufreq/omap-cpufreq.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c
b/drivers/cpufreq/arm_big_little.c
index bad2ed3..851f53b 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -332,7 +332,7 @@ static int _get_cluster_clk_and_freq_table(struct device
*cpu_dev)
 		goto out;
 	}
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster],
0);
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d,
err: %d\n",
 				__func__, cpu_dev->id, ret);
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 1bf6bba..2557860 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -158,7 +158,7 @@ static int cpu0_cpufreq_probe(struct platform_device
*pdev)
 		goto out_put_node;
 	}
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table, 0);
 	if (ret) {
 		pr_err("failed to init cpufreq table: %d\n", ret);
 		goto out_put_node;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c
b/drivers/cpufreq/imx6q-cpufreq.c
index e27fca8..c2bf03f 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -212,7 +212,7 @@ static int imx6q_cpufreq_probe(struct platform_device
*pdev)
 		}
 	}
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table, 0);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto put_node;
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 5f69c9a..afe9bf8 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -119,7 +119,7 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 		return PTR_ERR(policy->clk);
 
 	if (!freq_table) {
-		result = dev_pm_opp_init_cpufreq_table(mpu_dev,
&freq_table);
+		result = dev_pm_opp_init_cpufreq_table(mpu_dev, &freq_table,
0);
 		if (result) {
 			dev_err(mpu_dev,
 				"%s: cpu%d: failed creating freq
table[%d]\n",
-- 
1.7.10.4
