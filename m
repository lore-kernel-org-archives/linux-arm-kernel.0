From: marco.franchi@nxp.com (Marco Franchi)
Date: Thu, 5 Oct 2017 09:43:46 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx: Fix incorrect display nodes notation
Message-ID: <1507207427-32424-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warnings are seen with W=1:

Warning (unit_address_vs_reg): Node /display at di0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /display at di1 has a unit name, but no reg property

Fix all these warnings by changing 'display at diX' to 'dispX'.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
-none
 arch/arm/boot/dts/imx51-apf51dev.dts          | 2 +-
 arch/arm/boot/dts/imx51-babbage.dts           | 4 ++--
 arch/arm/boot/dts/imx51-ts4800.dts            | 2 +-
 arch/arm/boot/dts/imx53-m53evk.dts            | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts             | 2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi       | 2 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts         | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts   | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts   | 2 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts     | 2 +-
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts        | 2 +-
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts        | 2 +-
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts        | 2 +-
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts        | 2 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts  | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts         | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts  | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts         | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1036.dts         | 2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi      | 2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi           | 2 +-
 30 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index a5e6091..f04d0df 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -24,7 +24,7 @@
 		default-on;
 	};
 
-	display at di1 {
+	disp1 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "bgr666";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 873cf24..297953c 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -39,7 +39,7 @@
 		};
 	};
 
-	display0: display at di0 {
+	display0: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
@@ -66,7 +66,7 @@
 		};
 	};
 
-	display1: display at di1 {
+	display1: disp1 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb565";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index ca1cc5e..e6be869 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -50,7 +50,7 @@
 		power-supply = <&backlight_reg>;
 	};
 
-	display0: display at di0 {
+	display0: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 4347a32..9794a04 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -16,7 +16,7 @@
 	model = "Aries/DENX M53EVK";
 	compatible = "aries,imx53-m53evk", "denx,imx53-m53evk", "fsl,imx53";
 
-	display1: display at di1 {
+	display1: disp1 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "bgr666";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index df705ba..296dd74 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -30,7 +30,7 @@
 		power-supply = <&reg_backlight>;
 	};
 
-	disp1: display at disp1 {
+	disp1: disp1 {
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp1_1>;
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 683dcbe..d5adf33 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -22,7 +22,7 @@
 		      <0xb0000000 0x20000000>;
 	};
 
-	display0: display at di0 {
+	display0: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb565";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0ecb43d..b1ea73f 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -24,7 +24,7 @@
 	};
 
 	soc {
-		display: display at di0 {
+		display: disp0 {
 			compatible = "fsl,imx-parallel-display";
 			interface-pix-fmt = "rgb24";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index 0677625..5f0d196 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -52,7 +52,7 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	display0: display at di0 {
+	display0: disp0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,imx-parallel-display";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 32a812b..cc418ce 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -32,7 +32,7 @@
 	};
 
 	soc {
-		display0: display at di0 {
+		display0: disp0 {
 			compatible = "fsl,imx-parallel-display";
 			interface-pix-fmt = "rgb24";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 15203f0..126ff96 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -21,7 +21,7 @@
 	};
 
 	soc {
-		display0: display at di0 {
+		display0: disp0 {
 			compatible = "fsl,imx-parallel-display";
 			interface-pix-fmt = "rgb24";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 2654153..5705ebe 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -88,7 +88,7 @@
 		};
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
index aac42ac..389fc16 100644
--- a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
index ff8f7b1..a21075b 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
@@ -81,7 +81,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp0_2>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
index f988950..fee8854 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -81,7 +81,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp0_2>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
index d1f1298..efe5772 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
index 4d3204a..e222086 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-8033.dts
@@ -76,7 +76,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp0_2>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 4bbfe3d..8b56656 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -76,7 +76,7 @@
 		};
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index a35c7a5..27dc0fc 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -77,7 +77,7 @@
 		};
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 60d33e9..40b2c67 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -76,7 +76,7 @@
 		};
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
index 71746ed..d3ee1f5 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
index f9cd21a..e14e6be 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index 959ff3fb..ea84561 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
index b49133d..9c168ee 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
@@ -73,7 +73,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1036.dts b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
index 7c152e3..c81e8bd 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1036.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1036.dts
@@ -76,7 +76,7 @@
 		default-brightness-level = <50>;
 	};
 
-	display: display at di0 {
+	display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_disp0_2>;
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index 9cd2a74..37a59a8 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -54,7 +54,7 @@
 		stdout-path = &uart4;
 	};
 
-	display at di0 {
+	disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "bgr666";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index b63134e..472b0c9 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -256,7 +256,7 @@
 		status = "okay";
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index a24e4f1..4bab60a 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -120,7 +120,7 @@
 		};
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index d309a4d..9a46cf1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -197,7 +197,7 @@
 		status = "okay";
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 756c505..fc1f2c0 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -221,7 +221,7 @@
 		status = "okay";
 	};
 
-	lcd_display: display at di0 {
+	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index ec745eb..5610d19 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -424,7 +424,7 @@
 	display = <&display>;
 	status = "okay";
 
-	display: display at di0 {
+	display: disp0 {
 		bits-per-pixel = <32>;
 		bus-width = <24>;
 		status = "okay";
-- 
2.7.4
