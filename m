From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 14:31:44 -0700
Subject: [PATCH 01/10] ARM: dts: qcom: Label serial nodes for aliasing and
 stdout-path
In-Reply-To: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
References: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434490313-13905-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a label to the serial nodes that are being used for the
console.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 7084010ee61b..0554fbd72c40 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -234,7 +234,7 @@
 			interrupts = <0 208 0>;
 		};
 
-		serial at f995e000 {
+		blsp2_uart2: serial at f995e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf995e000 0x1000>;
 			interrupts = <0 114 0x0>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9f727d8eadf6..fa698635eea0 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -197,7 +197,7 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 16340000 {
+			gsbi4_serial: serial at 16340000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16340000 0x1000>,
 				      <0x16300000 0x1000>;
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index e0b2ce2910e0..80070bd41d5d 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -97,7 +97,7 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 19c40000 {
+			gsbi12_serial: serial at 19c40000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
 				      <0x19c00000 0x1000>;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index a02b984cc68d..502d332eb7bc 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -139,7 +139,7 @@
 
 			syscon-tcsr = <&tcsr>;
 
-			serial at 16440000 {
+			gsbi5_serial: serial at 16440000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16440000 0x1000>,
 				      <0x16400000 0x1000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 37b47b5538b8..d549f7edf21f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -227,7 +227,7 @@
 			reg = <0xfd8c0000 0x6000>;
 		};
 
-		serial at f991e000 {
+		blsp1_uart2: serial at f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
 			interrupts = <0 108 0x0>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
