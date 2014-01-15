From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 10:47:33 -0800
Subject: [PATCH v5 13/14] devicetree: bindings: Document qcom,gcc
In-Reply-To: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
References: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1389811654-21397-14-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the global clock controller found on Qualcomm devices.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
new file mode 100644
index 000000000000..767401f42871
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -0,0 +1,21 @@
+Qualcomm Global Clock & Reset Controller Binding
+------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,gcc-msm8660"
+			"qcom,gcc-msm8960"
+			"qcom,gcc-msm8974"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+- #reset-cells : shall contain 1
+
+Example:
+	clock-controller at 900000 {
+		compatible = "qcom,gcc-msm8960";
+		reg = <0x900000 0x4000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
