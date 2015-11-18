From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:12:29 -0800
Subject: [PATCH 4/4] arm64: dts: qcom: Add pm8994 gpios and MPPs
In-Reply-To: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
References: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447809149-29724-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the gpio and MPP devices to the pm8994 pmic dts.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm8994.dtsi | 43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index e61b376f0b7c..1732f1d32f4c 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -8,6 +8,49 @@
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8994_gpios: gpios at c000 {
+			compatible = "qcom,pm8994-gpio";
+			reg = <0xc000 0x1500>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				     <0 0xc1 0 IRQ_TYPE_NONE>,
+				     <0 0xc2 0 IRQ_TYPE_NONE>,
+				     <0 0xc3 0 IRQ_TYPE_NONE>,
+				     <0 0xc4 0 IRQ_TYPE_NONE>,
+				     <0 0xc5 0 IRQ_TYPE_NONE>,
+				     <0 0xc6 0 IRQ_TYPE_NONE>,
+				     <0 0xc7 0 IRQ_TYPE_NONE>,
+				     <0 0xc8 0 IRQ_TYPE_NONE>,
+				     <0 0xc9 0 IRQ_TYPE_NONE>,
+				     <0 0xca 0 IRQ_TYPE_NONE>,
+				     <0 0xcb 0 IRQ_TYPE_NONE>,
+				     <0 0xcc 0 IRQ_TYPE_NONE>,
+				     <0 0xcd 0 IRQ_TYPE_NONE>,
+				     <0 0xce 0 IRQ_TYPE_NONE>,
+				     <0 0xd0 0 IRQ_TYPE_NONE>,
+				     <0 0xd1 0 IRQ_TYPE_NONE>,
+				     <0 0xd2 0 IRQ_TYPE_NONE>,
+				     <0 0xd3 0 IRQ_TYPE_NONE>,
+				     <0 0xd4 0 IRQ_TYPE_NONE>,
+				     <0 0xd5 0 IRQ_TYPE_NONE>;
+		};
+
+		pm8994_mpps: mpps at a000 {
+			compatible = "qcom,pm8994-mpp";
+			reg = <0xa000 0x700>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
+				     <0 0xa1 0 IRQ_TYPE_NONE>,
+				     <0 0xa2 0 IRQ_TYPE_NONE>,
+				     <0 0xa3 0 IRQ_TYPE_NONE>,
+				     <0 0xa4 0 IRQ_TYPE_NONE>,
+				     <0 0xa5 0 IRQ_TYPE_NONE>,
+				     <0 0xa6 0 IRQ_TYPE_NONE>,
+				     <0 0xa7 0 IRQ_TYPE_NONE>;
+		};
 	};
 
 	pmic at 1 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
