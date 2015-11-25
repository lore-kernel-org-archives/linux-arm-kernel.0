From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 14:27:37 -0800
Subject: [PATCH 2/2] ARM64: dts: qcom: Remove size elements from pmic reg
 properties
In-Reply-To: <1448490457-9799-1-git-send-email-sboyd@codeaurora.org>
References: <1448490457-9799-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448490457-9799-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #size-cells for the pmics are 0, but we specify a size in the
reg property so that MPP and GPIO modules can figure out how many
pins there are. Now that we've done that by counting irqs, we can
remove the size elements in the reg properties and be DT
compliant.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 37432451ee4c..f71679b15d54 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -12,7 +12,7 @@
 
 		rtc at 6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000 0x6100>;
+			reg = <0x6000>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
@@ -27,7 +27,7 @@
 
 		pm8916_gpios: gpios at c000 {
 			compatible = "qcom,pm8916-gpio";
-			reg = <0xc000 0x400>;
+			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
@@ -38,7 +38,7 @@
 
 		pm8916_mpps: mpps at a000 {
 			compatible = "qcom,pm8916-mpp";
-			reg = <0xa000 0x400>;
+			reg = <0xa000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
@@ -49,7 +49,7 @@
 
 		pm8916_temp: temp-alarm at 2400 {
 			compatible = "qcom,spmi-temp-alarm";
-			reg = <0x2400 0x100>;
+			reg = <0x2400>;
 			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 			io-channels = <&pm8916_vadc VADC_DIE_TEMP>;
 			io-channel-names = "thermal";
@@ -58,7 +58,7 @@
 
 		pm8916_vadc: vadc at 3100 {
 			compatible = "qcom,spmi-vadc";
-			reg = <0x3100 0x100>;
+			reg = <0x3100>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
