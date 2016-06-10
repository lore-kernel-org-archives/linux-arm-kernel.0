From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Jun 2016 10:38:34 +0100
Subject: [PATCH 1/2] ARM: dts: apq8064: move sdcc1 pinctrl nodes to soc file
Message-ID: <1465551515-21622-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves out the sdcc1 pinctrl nodes out of board files to soc file,
so that it will be duplicated in other board files.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi           | 20 ++++++++++++++++++++
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts | 22 ----------------------
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  2 ++
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 4102a98..ca683e5 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -7,6 +7,26 @@
 		};
 	};
 
+	sdcc1_pins: sdcc1-pin-active {
+		clk {
+			pins = "sdc1_clk";
+			drive-strengh = <16>;
+			bias-disable;
+		};
+
+		cmd {
+			pins = "sdc1_cmd";
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+
+		data {
+			pins = "sdc1_data";
+			drive-strengh = <10>;
+			bias-pull-up;
+		};
+	};
+
 	ps_hold: ps_hold {
 		mux {
 			pins = "gpio78";
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
index 06b3c76..93d08b9 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
@@ -70,25 +70,6 @@
 				};
 			};
 
-			sdcc1_pin_a: sdcc1-pin-active {
-				clk {
-					pins = "sdc1_clk";
-					drive-strengh = <16>;
-					bias-disable;
-				};
-
-				cmd {
-					pins = "sdc1_cmd";
-					drive-strengh = <10>;
-					bias-pull-up;
-				};
-
-				data {
-					pins = "sdc1_data";
-					drive-strengh = <10>;
-					bias-pull-up;
-				};
-			};
 
 			sdcc3_pin_a: sdcc3-pin-active {
 				clk {
@@ -417,9 +398,6 @@
 
 				vmmc-supply = <&pm8921_l5>;
 				vqmmc-supply = <&pm8921_s4>;
-
-				pinctrl-names = "default";
-				pinctrl-0 = <&sdcc1_pin_a>;
 			};
 
 			sdcc3: sdcc at 12180000 {
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index cf37d55..ce7ce84 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -859,6 +859,8 @@
 			sdcc1: sdcc at 12400000 {
 				status		= "disabled";
 				compatible	= "arm,pl18x", "arm,primecell";
+				pinctrl-names	= "default";
+				pinctrl-0	= <&sdcc1_pins>;
 				arm,primecell-periphid = <0x00051180>;
 				reg		= <0x12400000 0x2000>;
 				interrupts	= <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.8.3
