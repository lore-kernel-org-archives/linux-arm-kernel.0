From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jan 2015 18:05:35 -0800
Subject: [PATCH v3 8/8] devicetree: bindings: Document qcom,lcc
In-Reply-To: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
References: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1421719535-28398-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Document the LPASS (low power audio subsystem) clock controller
found on Qualcomm devices.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,lcc.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lcc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,lcc.txt b/Documentation/devicetree/bindings/clock/qcom,lcc.txt
new file mode 100644
index 000000000000..dd755be63a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,lcc.txt
@@ -0,0 +1,21 @@
+Qualcomm LPASS Clock & Reset Controller Binding
+------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,lcc-msm8960"
+			"qcom,lcc-apq8064"
+			"qcom,lcc-ipq8064"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+- #reset-cells : shall contain 1
+
+Example:
+	clock-controller at 28000000 {
+		compatible = "qcom,lcc-ipq8064";
+		reg = <0x28000000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
