From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Mon,  4 Dec 2017 17:12:10 +0900
Subject: [PATCH] arm: dts: uniphier: add efuse node for UniPhier 32bit SoC
Message-ID: <1512375130-16860-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add efuse node for UniPhier LD4, Pro4, sLD8, Pro5 and PXs2.
This efuse node is included in soc-glue.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 18 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 33 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 18 ++++++++++++++++++
 5 files changed, 110 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 01fc3e1..6883f3b 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -273,6 +273,24 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-ld4-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 130 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x130 0x8>;
+			};
+		};
+
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 7955c3a..150726b 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -294,6 +294,29 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-pro4-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 130 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x130 0x8>;
+			};
+
+			efuse at 200 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x200 0x14>;
+			};
+		};
+
 		aidet: aidet at 5fc20000 {
 			compatible = "socionext,uniphier-pro4-aidet";
 			reg = <0x5fc20000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 6589b8a..f291dd6 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -355,6 +355,39 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-pro5-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 130 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x130 0x8>;
+			};
+
+			efuse at 200 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x200 0x28>;
+			};
+
+			efuse at 300 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x300 0x14>;
+			};
+
+			efuse at 400 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x400 0x8>;
+			};
+		};
+
 		aidet: aidet at 5fc20000 {
 			compatible = "socionext,uniphier-pro5-aidet";
 			reg = <0x5fc20000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index d82d6d8..8e54e87 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -375,6 +375,24 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-pxs2-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 200 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x200 0x58>;
+			};
+		};
+
 		aidet: aidet at 5fc20000 {
 			compatible = "socionext,uniphier-pxs2-aidet";
 			reg = <0x5fc20000 0x200>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 7188536..afafe7c 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -277,6 +277,24 @@
 			};
 		};
 
+		soc-glue at 5f900000 {
+			compatible = "socionext,uniphier-sld8-soc-glue-debug",
+				     "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x5f900000 0x2000>;
+
+			efuse at 100 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x100 0x28>;
+			};
+
+			efuse at 200 {
+				compatible = "socionext,uniphier-efuse";
+				reg = <0x200 0x14>;
+			};
+		};
+
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-- 
2.7.4
