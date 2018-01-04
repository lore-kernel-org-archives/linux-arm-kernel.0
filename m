From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:09 +0200
Subject: [PATCH v2 05/11] clk: qcom: Add DT bindings for CPU clock driver for
 msm8996
In-Reply-To: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
References: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <1515064215-22202-6-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
new file mode 100644
index 0000000..c45de03
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
@@ -0,0 +1,17 @@
+Qualcomm CPUSS clock controller for Kryo CPUs
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,apcc-msm8996"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+
+Example:
+	kryocc: clock-controller at 6400000 {
+		compatible = "qcom,apcc-msm8996";
+		reg = <0x6400000 0x90000>;
+		#clock-cells = <1>;
+	};
-- 
1.9.1
