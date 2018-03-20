From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 20 Mar 2018 09:28:44 +0530
Subject: [PATCH v3 01/13] firmware: qcom: scm: Add ipq4019 soc compatible
In-Reply-To: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1521518336-5467-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible for ipq4019.
This does not need clocks to do scm calls.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
 drivers/firmware/qcom_scm.c                             | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index 7b40054..fcf6979 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -11,9 +11,10 @@ Required properties:
  * "qcom,scm-msm8660" for MSM8660 platforms
  * "qcom,scm-msm8690" for MSM8690 platforms
  * "qcom,scm-msm8996" for MSM8996 platforms
+ * "qcom,scm-ipq4019" for IPQ4019 platforms
  * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
 - clocks: One to three clocks may be required based on compatible.
- * No clock required for "qcom,scm-msm8996"
+ * No clock required for "qcom,scm-msm8996", "qcom,scm-ipq4019"
  * Only core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660", and "qcom,scm-msm8960"
  * Core, iface, and bus clocks required for "qcom,scm"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 5a7d6930..e778af7 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -603,6 +603,9 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
 	{ .compatible = "qcom,scm-msm8996",
 	  .data = NULL, /* no clocks */
 	},
+	{ .compatible = "qcom,scm-ipq4019",
+	  .data = NULL, /* no clocks */
+	},
 	{ .compatible = "qcom,scm",
 	  .data = (void *)(SCM_HAS_CORE_CLK
 			   | SCM_HAS_IFACE_CLK
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
