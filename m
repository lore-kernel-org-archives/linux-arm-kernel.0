From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 11:18:12 +0900
Subject: [PATCH 3/3] ARM: dts: uniphier: add outer cache controller nodes
In-Reply-To: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440382692-3855-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L2 cache controller nodes for all the UniPhier SoC DTSI.
Also, add an L3 cache controller node for PH1-Pro5 DTSI.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     |  7 +++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    |  7 +++++++
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    |  7 +++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    |  7 +++++++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi |  7 +++++++
 6 files changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index a6a185f..2d60960 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -91,6 +91,13 @@
 			#size-cells = <1>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index e8bbc45..02acc07 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -98,6 +98,13 @@
 			#size-cells = <1>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 59c2b12..084bc47 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -98,6 +98,20 @@
 			#size-cells = <1>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 190 4>, <0 191 4>;
+		};
+
+		l3-cache at 500c8000 {
+			compatible = "socionext,uniphier-l3-cache";
+			reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
+			      <0x506c8000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 3cc90cd..e989281 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -120,6 +120,13 @@
 			      <0x20000100 0x100>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index 58067df..3ff897c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -91,6 +91,13 @@
 			#size-cells = <1>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 4c7b246..f318548 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -110,6 +110,13 @@
 			#size-cells = <1>;
 		};
 
+		l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-l2-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
-- 
1.9.1
