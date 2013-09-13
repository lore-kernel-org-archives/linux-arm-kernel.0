From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:31:16 +0530
Subject: [PATCH 130/228] cpufreq: cris: use cpufreq_generic_init() routine
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <2b5bec06ece382705b51aaf97f53762ff540639f.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel at axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 6 +-----
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 4d88e4f..05fdc7e 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -71,13 +71,9 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
-
 static struct cpufreq_driver cris_freq_driver = {
 	.get	= cris_freq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index f7d2d49..fac2b26 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -70,10 +70,7 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
 static struct cpufreq_driver cris_freq_driver = {
-- 
1.7.12.rc2.18.g61b472e
