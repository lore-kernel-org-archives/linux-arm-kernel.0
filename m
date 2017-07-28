From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Fri, 28 Jul 2017 18:48:13 +0530
Subject: [PATCH v2 2/2] arm64: dts: pmi8994: Add device node for pmi8994 gpios
In-Reply-To: <1501247893-30226-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1501247893-30226-1-git-send-email-vivek.gautam@codeaurora.org>
Message-ID: <1501247893-30226-2-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Changes since v1:
 - Added "qcom,spmi-gpio" to the compatible.

 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index d3879a4e8076..57673f92805d 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -8,6 +8,23 @@
 		reg = <0x2 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pmi8994_gpios: gpios at c000 {
+			compatible = "qcom,pmi8994-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <2 0xc0 0 IRQ_TYPE_NONE>,
+				     <2 0xc1 0 IRQ_TYPE_NONE>,
+				     <2 0xc2 0 IRQ_TYPE_NONE>,
+				     <2 0xc3 0 IRQ_TYPE_NONE>,
+				     <2 0xc4 0 IRQ_TYPE_NONE>,
+				     <2 0xc5 0 IRQ_TYPE_NONE>,
+				     <2 0xc6 0 IRQ_TYPE_NONE>,
+				     <2 0xc7 0 IRQ_TYPE_NONE>,
+				     <2 0xc8 0 IRQ_TYPE_NONE>,
+				     <2 0xc9 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	pmic at 3 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
