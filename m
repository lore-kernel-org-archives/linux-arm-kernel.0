From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:53:21 -0500
Subject: [Patch v2 02/10] soc: qcom: smd-rpm: Add existing platform support
In-Reply-To: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443027209-19444-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for all current Qualcomm platforms which utilize
RPM over SMD.  This includes both MSM8916 and APQ8084.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |    2 ++
 drivers/soc/qcom/smd-rpm.c                         |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index 3710dd5..7d05246 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -20,6 +20,8 @@ resources.
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,rpm-msm8974"
+		    "qcom,rpm-msm8916"
+		    "qcom,rpm-apq8084"
 
 - qcom,smd-channels:
 	Usage: required
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 1392ccf..455083c 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -212,6 +212,8 @@ static void qcom_smd_rpm_remove(struct qcom_smd_device *sdev)
 
 static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-msm8974" },
+	{ .compatible = "qcom,rpm-msm8916" },
+	{ .compatible = "qcom,rpm-apq8084" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
