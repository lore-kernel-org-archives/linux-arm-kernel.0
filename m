From: agross@codeaurora.org (Andy Gross)
Date: Thu, 24 Sep 2015 14:18:51 -0500
Subject: [Patch v3 02/10] soc: qcom: smd-rpm: Add existing platform support
In-Reply-To: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
References: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443122339-13917-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for all current Qualcomm platforms which utilize
RPM over SMD.  This includes both MSM8916 and APQ8084.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |    2 ++
 drivers/soc/qcom/smd-rpm.c                         |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index 003bedd..18d4d04 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -19,6 +19,8 @@ resources.
 	Usage: required
 	Value type: <string>
 	Definition: must be one of:
+		    "qcom,rpm-apq8084"
+		    "qcom,rpm-msm8916"
 		    "qcom,rpm-msm8974"
 
 - qcom,smd-channels:
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 1392ccf..e8450f3 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -211,6 +211,8 @@ static void qcom_smd_rpm_remove(struct qcom_smd_device *sdev)
 }
 
 static const struct of_device_id qcom_smd_rpm_of_match[] = {
+	{ .compatible = "qcom,rpm-apq8084" },
+	{ .compatible = "qcom,rpm-msm8916" },
 	{ .compatible = "qcom,rpm-msm8974" },
 	{}
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
