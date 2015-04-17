From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 17 Apr 2015 17:49:05 -0600
Subject: [PATCH RFC 3/7] qcom: spm: Use u32 for register offsets
In-Reply-To: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
References: <1429314549-6730-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1429314549-6730-4-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer SoC's allow a bigger memory range for the SPM. The offsets for the
SPM sequences could therefore, be more than the capcacity of u8.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b66d86c..392a714 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -60,7 +60,7 @@ enum spm_reg {
 };
 
 struct spm_reg_data {
-	const u8 *reg_offset;
+	const u32 *reg_offset;
 	u32 spm_cfg;
 	u32 spm_dly;
 	u32 pmic_dly;
@@ -74,7 +74,7 @@ struct spm_driver_data {
 	const struct spm_reg_data *reg_data;
 };
 
-static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
+static const u32 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
 	[SPM_REG_DLY]		= 0x34,
@@ -93,7 +93,7 @@ static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
 	.start_index[PM_SLEEP_MODE_SPC] = 3,
 };
 
-static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
+static const u32 spm_reg_offset_v1_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x20,
 	[SPM_REG_PMIC_DLY]	= 0x24,
-- 
2.1.0
