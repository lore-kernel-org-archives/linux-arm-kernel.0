From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:06 -0600
Subject: [PATCH 12/26] coresight: Use the new helper for defining registers
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-13-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use the new helpers for exposing coresight component registers,
choosing the 64bit variants for appropriate registers.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c      | 22 ++++++++--------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 26 +++++++++----------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 24 ++++++++---------
 drivers/hwtracing/coresight/coresight-stm.c        | 30 +++++++++++-----------
 drivers/hwtracing/coresight/coresight-tmc.c        | 30 ++++++++++++----------
 5 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d0d186575c5d..05625e3a584e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -575,17 +575,17 @@ static const struct file_operations etb_fops = {
 	.llseek		= no_llseek,
 };
 
-#define coresight_etb10_simple_func(name, offset)                       \
-	coresight_simple_func(struct etb_drvdata, NULL, name, offset)
-
-coresight_etb10_simple_func(rdp, ETB_RAM_DEPTH_REG);
-coresight_etb10_simple_func(sts, ETB_STATUS_REG);
-coresight_etb10_simple_func(rrp, ETB_RAM_READ_POINTER);
-coresight_etb10_simple_func(rwp, ETB_RAM_WRITE_POINTER);
-coresight_etb10_simple_func(trg, ETB_TRG);
-coresight_etb10_simple_func(ctl, ETB_CTL_REG);
-coresight_etb10_simple_func(ffsr, ETB_FFSR);
-coresight_etb10_simple_func(ffcr, ETB_FFCR);
+#define coresight_etb10_reg(name, offset)		\
+	coresight_simple_reg32(struct etb_drvdata, name, offset)
+
+coresight_etb10_reg(rdp, ETB_RAM_DEPTH_REG);
+coresight_etb10_reg(sts, ETB_STATUS_REG);
+coresight_etb10_reg(rrp, ETB_RAM_READ_POINTER);
+coresight_etb10_reg(rwp, ETB_RAM_WRITE_POINTER);
+coresight_etb10_reg(trg, ETB_TRG);
+coresight_etb10_reg(ctl, ETB_CTL_REG);
+coresight_etb10_reg(ffsr, ETB_FFSR);
+coresight_etb10_reg(ffcr, ETB_FFCR);
 
 static struct attribute *coresight_etb_mgmt_attrs[] = {
 	&dev_attr_rdp.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index ca98ad13bb8c..6e547ec6fead 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1232,19 +1232,19 @@ static struct attribute *coresight_etm_attrs[] = {
 	NULL,
 };
 
-#define coresight_etm3x_simple_func(name, offset)			\
-	coresight_simple_func(struct etm_drvdata, NULL, name, offset)
-
-coresight_etm3x_simple_func(etmccr, ETMCCR);
-coresight_etm3x_simple_func(etmccer, ETMCCER);
-coresight_etm3x_simple_func(etmscr, ETMSCR);
-coresight_etm3x_simple_func(etmidr, ETMIDR);
-coresight_etm3x_simple_func(etmcr, ETMCR);
-coresight_etm3x_simple_func(etmtraceidr, ETMTRACEIDR);
-coresight_etm3x_simple_func(etmteevr, ETMTEEVR);
-coresight_etm3x_simple_func(etmtssvr, ETMTSSCR);
-coresight_etm3x_simple_func(etmtecr1, ETMTECR1);
-coresight_etm3x_simple_func(etmtecr2, ETMTECR2);
+#define coresight_etm3x_reg(name, offset)			\
+	coresight_simple_reg32(struct etm_drvdata, name, offset)
+
+coresight_etm3x_reg(etmccr, ETMCCR);
+coresight_etm3x_reg(etmccer, ETMCCER);
+coresight_etm3x_reg(etmscr, ETMSCR);
+coresight_etm3x_reg(etmidr, ETMIDR);
+coresight_etm3x_reg(etmcr, ETMCR);
+coresight_etm3x_reg(etmtraceidr, ETMTRACEIDR);
+coresight_etm3x_reg(etmteevr, ETMTEEVR);
+coresight_etm3x_reg(etmtssvr, ETMTSSCR);
+coresight_etm3x_reg(etmtecr1, ETMTECR1);
+coresight_etm3x_reg(etmtecr2, ETMTECR2);
 
 static struct attribute *coresight_etm_mgmt_attrs[] = {
 	&dev_attr_etmccr.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b9b1e9c8f4c4..4e6eab53e34e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2066,23 +2066,23 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
 	return reg.data;
 }
 
-#define coresight_etm4x_simple_func(name, offset)			\
-	coresight_simple_func(struct etmv4_drvdata, NULL, name, offset)
+#define coresight_etm4x_reg(name, offset)			\
+	coresight_simple_reg32(struct etmv4_drvdata, name, offset)
 
 #define coresight_etm4x_cross_read(name, offset)			\
 	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
 			      name, offset)
 
-coresight_etm4x_simple_func(trcpdcr, TRCPDCR);
-coresight_etm4x_simple_func(trcpdsr, TRCPDSR);
-coresight_etm4x_simple_func(trclsr, TRCLSR);
-coresight_etm4x_simple_func(trcauthstatus, TRCAUTHSTATUS);
-coresight_etm4x_simple_func(trcdevid, TRCDEVID);
-coresight_etm4x_simple_func(trcdevtype, TRCDEVTYPE);
-coresight_etm4x_simple_func(trcpidr0, TRCPIDR0);
-coresight_etm4x_simple_func(trcpidr1, TRCPIDR1);
-coresight_etm4x_simple_func(trcpidr2, TRCPIDR2);
-coresight_etm4x_simple_func(trcpidr3, TRCPIDR3);
+coresight_etm4x_reg(trcpdcr, TRCPDCR);
+coresight_etm4x_reg(trcpdsr, TRCPDSR);
+coresight_etm4x_reg(trclsr, TRCLSR);
+coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS);
+coresight_etm4x_reg(trcdevid, TRCDEVID);
+coresight_etm4x_reg(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_reg(trcpidr0, TRCPIDR0);
+coresight_etm4x_reg(trcpidr1, TRCPIDR1);
+coresight_etm4x_reg(trcpidr2, TRCPIDR2);
+coresight_etm4x_reg(trcpidr3, TRCPIDR3);
 coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
 coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
 coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 93fc26f01bab..202ed7a909e1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -635,21 +635,21 @@ static ssize_t traceid_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(traceid);
 
-#define coresight_stm_simple_func(name, offset)	\
-	coresight_simple_func(struct stm_drvdata, NULL, name, offset)
-
-coresight_stm_simple_func(tcsr, STMTCSR);
-coresight_stm_simple_func(tsfreqr, STMTSFREQR);
-coresight_stm_simple_func(syncr, STMSYNCR);
-coresight_stm_simple_func(sper, STMSPER);
-coresight_stm_simple_func(spter, STMSPTER);
-coresight_stm_simple_func(privmaskr, STMPRIVMASKR);
-coresight_stm_simple_func(spscr, STMSPSCR);
-coresight_stm_simple_func(spmscr, STMSPMSCR);
-coresight_stm_simple_func(spfeat1r, STMSPFEAT1R);
-coresight_stm_simple_func(spfeat2r, STMSPFEAT2R);
-coresight_stm_simple_func(spfeat3r, STMSPFEAT3R);
-coresight_stm_simple_func(devid, CORESIGHT_DEVID);
+#define coresight_stm_reg(name, offset)	\
+	coresight_simple_reg32(struct stm_drvdata, name, offset)
+
+coresight_stm_reg(tcsr, STMTCSR);
+coresight_stm_reg(tsfreqr, STMTSFREQR);
+coresight_stm_reg(syncr, STMSYNCR);
+coresight_stm_reg(sper, STMSPER);
+coresight_stm_reg(spter, STMSPTER);
+coresight_stm_reg(privmaskr, STMPRIVMASKR);
+coresight_stm_reg(spscr, STMSPSCR);
+coresight_stm_reg(spmscr, STMSPMSCR);
+coresight_stm_reg(spfeat1r, STMSPFEAT1R);
+coresight_stm_reg(spfeat2r, STMSPFEAT2R);
+coresight_stm_reg(spfeat3r, STMSPFEAT3R);
+coresight_stm_reg(devid, CORESIGHT_DEVID);
 
 static struct attribute *coresight_stm_attrs[] = {
 	&dev_attr_hwevent_enable.attr,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 864488793f09..5abf711320f6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -217,20 +217,22 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 	return memwidth;
 }
 
-#define coresight_tmc_simple_func(name, offset)			\
-	coresight_simple_func(struct tmc_drvdata, NULL, name, offset)
-
-coresight_tmc_simple_func(rsz, TMC_RSZ);
-coresight_tmc_simple_func(sts, TMC_STS);
-coresight_tmc_simple_func(rrp, TMC_RRP);
-coresight_tmc_simple_func(rwp, TMC_RWP);
-coresight_tmc_simple_func(trg, TMC_TRG);
-coresight_tmc_simple_func(ctl, TMC_CTL);
-coresight_tmc_simple_func(ffsr, TMC_FFSR);
-coresight_tmc_simple_func(ffcr, TMC_FFCR);
-coresight_tmc_simple_func(mode, TMC_MODE);
-coresight_tmc_simple_func(pscr, TMC_PSCR);
-coresight_tmc_simple_func(devid, CORESIGHT_DEVID);
+#define coresight_tmc_reg(name, offset)			\
+	coresight_simple_reg32(struct tmc_drvdata, name, offset)
+#define coresight_tmc_reg64(name, lo_off, hi_off)	\
+	coresight_simple_reg64(struct tmc_drvdata, name, lo_off, hi_off)
+
+coresight_tmc_reg(rsz, TMC_RSZ);
+coresight_tmc_reg(sts, TMC_STS);
+coresight_tmc_reg(trg, TMC_TRG);
+coresight_tmc_reg(ctl, TMC_CTL);
+coresight_tmc_reg(ffsr, TMC_FFSR);
+coresight_tmc_reg(ffcr, TMC_FFCR);
+coresight_tmc_reg(mode, TMC_MODE);
+coresight_tmc_reg(pscr, TMC_PSCR);
+coresight_tmc_reg(devid, CORESIGHT_DEVID);
+coresight_tmc_reg64(rrp, TMC_RRP, TMC_RRPHI);
+coresight_tmc_reg64(rwp, TMC_RWP, TMC_RWPHI);
 
 static struct attribute *coresight_tmc_mgmt_attrs[] = {
 	&dev_attr_rsz.attr,
-- 
2.7.4
