From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 11:59:45 +0900
Subject: [PATCH 2/3] ARM: dts: uniphier: add SoC-Glue node to UniPhier 32bit
 SoCs
In-Reply-To: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1465873186-30658-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This node consists of various system-level configuration registers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi    | 10 +++++++---
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     |  2 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi    |  2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    |  2 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    |  2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    |  2 +-
 arch/arm/boot/dts/uniphier-proxstream2.dtsi |  2 +-
 7 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
index 891327f..03f60ec 100644
--- a/arch/arm/boot/dts/uniphier-common32.dtsi
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -136,9 +136,13 @@
 			interrupt-controller;
 		};
 
-		pinctrl: pinctrl at 5f801000 {
-			/* specify compatible in each SoC DTSI */
-			reg = <0x5f801000 0xe00>;
+		soc-glue at 5f800000 {
+			compatible = "simple-mfd", "syscon";
+			reg = <0x5f800000 0x2000>;
+
+			pinctrl: pinctrl {
+				 /* specify compatible in each SoC DTSI */
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index dadd860..debad7f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -182,5 +182,5 @@
 };
 
 &pinctrl {
-	compatible = "socionext,ph1-ld4-pinctrl", "syscon";
+	compatible = "socionext,uniphier-ld4-pinctrl";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
index 5321152..19c107c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
@@ -63,5 +63,5 @@
  * which makes the pinctrl driver unshareable.
  */
 &pinctrl {
-	compatible = "socionext,ph1-ld6b-pinctrl", "syscon";
+	compatible = "socionext,uniphier-ld6b-pinctrl";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index 20f3f2a..7b9da08 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -200,5 +200,5 @@
 };
 
 &pinctrl {
-	compatible = "socionext,ph1-pro4-pinctrl", "syscon";
+	compatible = "socionext,uniphier-pro4-pinctrl";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 24f6f66..7e4aa2f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -194,5 +194,5 @@
 };
 
 &pinctrl {
-	compatible = "socionext,ph1-pro5-pinctrl", "syscon";
+	compatible = "socionext,uniphier-pro5-pinctrl";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index 6bfd29a..467f9d8 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -181,5 +181,5 @@
 };
 
 &pinctrl {
-	compatible = "socionext,ph1-sld8-pinctrl", "syscon";
+	compatible = "socionext,uniphier-sld8-pinctrl";
 };
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 4ac484c..d00d6f5 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -205,5 +205,5 @@
 };
 
 &pinctrl {
-	compatible = "socionext,proxstream2-pinctrl", "syscon";
+	compatible = "socionext,uniphier-pxs2-pinctrl";
 };
-- 
1.9.1
