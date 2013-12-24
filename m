From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Dec 2013 17:12:39 -0800
Subject: [PATCH v4 15/15] devicetree: bindings: Document qcom,mmcc
In-Reply-To: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
References: <1387847559-18330-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1387847559-18330-16-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the multimedia clock controller found on MSM devices

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,mmcc.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,mmcc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
new file mode 100644
index 0000000..d572e99
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -0,0 +1,21 @@
+Qualcomm Multimedia Clock & Reset Controller Binding
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,mmcc-msm8660"
+			"qcom,mmcc-msm8960"
+			"qcom,mmcc-msm8974"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+- #reset-cells : shall contain 1
+
+Example:
+	clock-controller at 4000000 {
+		compatible = "qcom,mmcc-msm8960";
+		reg = <0x4000000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
