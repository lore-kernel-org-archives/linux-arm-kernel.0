From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 20 Jul 2017 11:17:19 +0100
Subject: [PATCH v5 09/19] coresight tmc: Expose DBA and AXICTL
In-Reply-To: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
References: <1500545849-23724-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500545849-23724-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose DBALO,DBAHI and AXICTL registers

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index aa40613..5b784c7 100644
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
2.7.5
