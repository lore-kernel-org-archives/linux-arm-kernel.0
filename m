From: agross@codeaurora.org (Andy Gross)
Date: Tue, 17 Jun 2014 23:49:11 -0500
Subject: [PATCH] pinctrl: qcom: Add BUS_HOLD pin bias
Message-ID: <1403066951-31266-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the BUS_HOLD (Keeper) bias option for pins.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/pinctrl/pinctrl-msm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index e43fbce..9aa2839 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -206,6 +206,7 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_BIAS_BUS_HOLD:
 	case PIN_CONFIG_BIAS_PULL_UP:
 		*bit = g->pull_bit;
 		*mask = 3;
@@ -243,6 +244,7 @@ static int msm_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 #define MSM_NO_PULL	0
 #define MSM_PULL_DOWN	1
+#define MSM_KEEPER	2
 #define MSM_PULL_UP	3
 
 static unsigned msm_regval_to_drive(u32 val)
@@ -280,6 +282,9 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 		arg = arg == MSM_PULL_DOWN;
 		break;
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		arg = arg == MSM_KEEPER;
+		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		arg = arg == MSM_PULL_UP;
 		break;
@@ -339,6 +344,9 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			arg = MSM_PULL_DOWN;
 			break;
+		case PIN_CONFIG_BIAS_BUS_HOLD:
+			arg = MSM_KEEPER;
+			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			arg = MSM_PULL_UP;
 			break;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
