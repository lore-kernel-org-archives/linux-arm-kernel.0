From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 14 Feb 2017 18:20:28 -0800
Subject: [PATCH 1/2] coresight: Replace sprintf with scnprintf
In-Reply-To: <20170215022029.21744-1-ohaugan@codeaurora.org>
References: <20170215022029.21744-1-ohaugan@codeaurora.org>
Message-ID: <20170215022029.21744-2-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace all occurrences of sprintf with scnprintf in coresight driver for
consistency. scnprintf is also a safer alternative to sprintf.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 66 +++++++++++-----------
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
 6 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d7325c6534ad..491f4da61c11 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -588,7 +588,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
 	struct etb_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t trigger_cntr_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 26cfac3e6de7..6ddcd186c085 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -467,7 +467,7 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 	struct device *pmu_dev = etm_pmu.dev;
 	struct device *cs_dev = &csdev->dev;
 
-	sprintf(entry, "cpu%d", cpu);
+	scnprintf(entry, PAGE_SIZE, "cpu%d", cpu);
 
 	if (!etm_perf_up)
 		return -EPROBE_DEFER;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index ca98ad13bb8c..4cbbd1313331 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -27,7 +27,7 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_addr_cmp;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
 
@@ -37,7 +37,7 @@ static ssize_t nr_cntr_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_cntr;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
 
@@ -48,7 +48,7 @@ static ssize_t nr_ctxid_cmp_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ctxid_cmp;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ctxid_cmp);
 
@@ -68,7 +68,7 @@ static ssize_t etmsr_show(struct device *dev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(drvdata->dev);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(etmsr);
 
@@ -110,7 +110,7 @@ static ssize_t mode_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->mode;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t mode_store(struct device *dev,
@@ -195,7 +195,7 @@ static ssize_t trigger_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->trigger_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t trigger_event_store(struct device *dev,
@@ -225,7 +225,7 @@ static ssize_t enable_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->enable_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t enable_event_store(struct device *dev,
@@ -255,7 +255,7 @@ static ssize_t fifofull_level_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->fifofull_level;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t fifofull_level_store(struct device *dev,
@@ -285,7 +285,7 @@ static ssize_t addr_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->addr_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t addr_idx_store(struct device *dev,
@@ -335,7 +335,7 @@ static ssize_t addr_single_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t addr_single_store(struct device *dev,
@@ -394,7 +394,7 @@ static ssize_t addr_range_show(struct device *dev,
 	val2 = config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx %#lx\n", val1, val2);
+	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t addr_range_store(struct device *dev,
@@ -456,7 +456,7 @@ static ssize_t addr_start_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t addr_start_store(struct device *dev,
@@ -510,7 +510,7 @@ static ssize_t addr_stop_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t addr_stop_store(struct device *dev,
@@ -556,7 +556,7 @@ static ssize_t addr_acctype_show(struct device *dev,
 	val = config->addr_acctype[config->addr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t addr_acctype_store(struct device *dev,
@@ -588,7 +588,7 @@ static ssize_t cntr_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->cntr_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t cntr_idx_store(struct device *dev,
@@ -629,7 +629,7 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 	val = config->cntr_rld_val[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t cntr_rld_val_store(struct device *dev,
@@ -664,7 +664,7 @@ static ssize_t cntr_event_show(struct device *dev,
 	val = config->cntr_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t cntr_event_store(struct device *dev,
@@ -699,7 +699,7 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 	val = config->cntr_rld_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t cntr_rld_event_store(struct device *dev,
@@ -734,7 +734,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	if (!local_read(&drvdata->mode)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
+			ret += scnprintf(buf, PAGE_SIZE, "counter %d: %x\n",
 				       i, config->cntr_val[i]);
 		spin_unlock(&drvdata->spinlock);
 		return ret;
@@ -742,7 +742,7 @@ static ssize_t cntr_val_show(struct device *dev,
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
+		ret += scnprintf(buf, PAGE_SIZE, "counter %d: %x\n", i, val);
 	}
 
 	return ret;
@@ -777,7 +777,7 @@ static ssize_t seq_12_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_12_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_12_event_store(struct device *dev,
@@ -806,7 +806,7 @@ static ssize_t seq_21_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_21_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_21_event_store(struct device *dev,
@@ -835,7 +835,7 @@ static ssize_t seq_23_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_23_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_23_event_store(struct device *dev,
@@ -864,7 +864,7 @@ static ssize_t seq_31_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_31_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_31_event_store(struct device *dev,
@@ -893,7 +893,7 @@ static ssize_t seq_32_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_32_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_32_event_store(struct device *dev,
@@ -922,7 +922,7 @@ static ssize_t seq_13_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_13_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_13_event_store(struct device *dev,
@@ -965,7 +965,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(drvdata->dev);
 out:
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t seq_curr_state_store(struct device *dev,
@@ -998,7 +998,7 @@ static ssize_t ctxid_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->ctxid_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t ctxid_idx_store(struct device *dev,
@@ -1040,7 +1040,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	val = config->ctxid_vpid[config->ctxid_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t ctxid_pid_store(struct device *dev,
@@ -1075,7 +1075,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->ctxid_mask;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t ctxid_mask_store(struct device *dev,
@@ -1104,7 +1104,7 @@ static ssize_t sync_freq_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->sync_freq;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t sync_freq_store(struct device *dev,
@@ -1133,7 +1133,7 @@ static ssize_t timestamp_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->timestamp_event;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t timestamp_event_store(struct device *dev,
@@ -1174,7 +1174,7 @@ static ssize_t traceid_show(struct device *dev,
 
 	val = etm_get_trace_id(drvdata);
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t traceid_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 860fe6ef5632..30cfd5c12b71 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -114,7 +114,7 @@ static ssize_t priority_show(struct device *dev,
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->priority;
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t priority_store(struct device *dev,
@@ -157,7 +157,7 @@ static ssize_t funnel_ctrl_show(struct device *dev,
 
 	pm_runtime_put(drvdata->dev);
 
-	return sprintf(buf, "%#x\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#x\n", val);
 }
 static DEVICE_ATTR_RO(funnel_ctrl);
 
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 93fc26f01bab..70b3eee7f4dd 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -614,7 +614,7 @@ static ssize_t traceid_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->traceid;
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t traceid_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index d8517d2a968c..1a660f014c6c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -253,7 +253,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
 
-	return sprintf(buf, "%#lx\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
 static ssize_t trigger_cntr_store(struct device *dev,
-- 
2.11.0
