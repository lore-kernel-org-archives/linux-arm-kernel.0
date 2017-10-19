From: bhumirks@gmail.com (Bhumika Goyal)
Date: Thu, 19 Oct 2017 12:59:15 +0200
Subject: [PATCH 2/2] cpufreq: arm_big_little: make cpufreq_arm_bL_ops
 structures const
In-Reply-To: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
References: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Message-ID: <1508410755-13666-3-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only getting passed to the functions
bL_cpufreq_{register/unregister} having the arguments as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/cpufreq/arm_big_little_dt.c    | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index 39b3f51..b944f29 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -61,7 +61,7 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 	return transition_latency;
 }
 
-static struct cpufreq_arm_bL_ops dt_bL_ops = {
+static const struct cpufreq_arm_bL_ops dt_bL_ops = {
 	.name	= "dt-bl",
 	.get_transition_latency = dt_get_transition_latency,
 	.init_opp_table = dev_pm_opp_of_cpumask_add_table,
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 8de2364..05d2990 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -53,7 +53,7 @@ static int scpi_init_opp_table(const struct cpumask *cpumask)
 	return ret;
 }
 
-static struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
+static const struct cpufreq_arm_bL_ops scpi_cpufreq_ops = {
 	.name	= "scpi",
 	.get_transition_latency = scpi_get_transition_latency,
 	.init_opp_table = scpi_init_opp_table,
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 87e5bdc..5323728 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -42,7 +42,7 @@ static int ve_spc_get_transition_latency(struct device *cpu_dev)
 	return 1000000; /* 1 ms */
 }
 
-static struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
+static const struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
 	.name	= "vexpress-spc",
 	.get_transition_latency = ve_spc_get_transition_latency,
 	.init_opp_table = ve_spc_init_opp_table,
-- 
1.9.1
