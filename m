From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 18 Sep 2015 13:37:34 +0900
Subject: [PATCH v3 3/3] ARM: dts: uniphier: add outer cache controller nodes
In-Reply-To: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
References: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1442551054-2116-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add L2 cache controller nodes for all the UniPhier SoC DTSI.
Also, add an L3 cache controller node for PH1-Pro5 DTSI.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 13 +++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 13 +++++++++++++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 16 ++++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index a6a185f..ae13469 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -55,6 +55,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -91,6 +92,18 @@
 			#size-cells = <1>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+			cache-unified;
+			cache-size = <(512 * 1024)>;
+			cache-sets = <256>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index e8bbc45..85377b2 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -56,12 +56,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -98,6 +100,18 @@
 			#size-cells = <1>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+			cache-unified;
+			cache-size = <(768 * 1024)>;
+			cache-sets = <256>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 59c2b12..96da01e 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -56,12 +56,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -98,6 +100,31 @@
 			#size-cells = <1>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 190 4>, <0 191 4>;
+			cache-unified;
+			cache-size = <(2 * 1024 * 1024)>;
+			cache-sets = <512>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+			next-level-cache = <&l3>;
+		};
+
+		l3: l3-cache at 500c8000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
+			      <0x506c8000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+			cache-unified;
+			cache-size = <(2 * 1024 * 1024)>;
+			cache-sets = <512>;
+			cache-line-size = <256>;
+			cache-level = <3>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 3cc90cd..945b37f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -56,12 +56,14 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -120,6 +122,18 @@
 			      <0x20000100 0x100>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+			cache-unified;
+			cache-size = <(512 * 1024)>;
+			cache-sets = <256>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index 58067df..c98428c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -55,6 +55,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -91,6 +92,18 @@
 			#size-cells = <1>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>;
+			cache-unified;
+			cache-size = <(256 * 1024)>;
+			cache-sets = <256>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 4c7b246..ad5fb39 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -56,24 +56,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			next-level-cache = <&l2>;
 		};
 
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			next-level-cache = <&l2>;
 		};
 	};
 
@@ -110,6 +114,18 @@
 			#size-cells = <1>;
 		};
 
+		l2: l2-cache at 500c0000 {
+			compatible = "socionext,uniphier-system-cache";
+			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
+			      <0x506c0000 0x400>;
+			interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
+			cache-unified;
+			cache-size = <(1280 * 1024)>;
+			cache-sets = <512>;
+			cache-line-size = <128>;
+			cache-level = <2>;
+		};
+
 		serial0: serial at 54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
-- 
1.9.1
