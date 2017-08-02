From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:08 -0600
Subject: [PATCH 14/26] coresight tmc: Expose DBA and AXICTL
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Expose DBALO,DBAHI and AXICTL registers

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 5abf711320f6..bd98b5101528 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -230,9 +230,11 @@ coresight_tmc_reg(ffsr, TMC_FFSR);
 coresight_tmc_reg(ffcr, TMC_FFCR);
 coresight_tmc_reg(mode, TMC_MODE);
 coresight_tmc_reg(pscr, TMC_PSCR);
+coresight_tmc_reg(axictl, TMC_AXICTL);
 coresight_tmc_reg(devid, CORESIGHT_DEVID);
 coresight_tmc_reg64(rrp, TMC_RRP, TMC_RRPHI);
 coresight_tmc_reg64(rwp, TMC_RWP, TMC_RWPHI);
+coresight_tmc_reg64(dba, TMC_DBALO, TMC_DBAHI);
 
 static struct attribute *coresight_tmc_mgmt_attrs[] = {
 	&dev_attr_rsz.attr,
@@ -246,6 +248,8 @@ static struct attribute *coresight_tmc_mgmt_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_pscr.attr,
 	&dev_attr_devid.attr,
+	&dev_attr_dba.attr,
+	&dev_attr_axictl.attr,
 	NULL,
 };
 
-- 
2.7.4
