From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 14 Mar 2014 11:06:40 +0100
Subject: [PATCH resend v3 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve
 and correct HSPI nodes
Message-ID: <1394791601-25317-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

  - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
    values,
  - Correct reference to parent interrupt controller
    (use "interrupt-parent" instead of "interrupt-controller"),
  - Add missing "#address-cells" and "#size-cells" properties, which are
    needed when populating the SPI buses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
resend:
  - Simon: The bindings updates (formerly 1/3) are now in spi/for-next,
    so please apply. Thanks!
v3:
  - Split in two patches: bindings and dtsi updates
v2:
  - Add Tested-by
  - List full example compatible properties with soctypes instead of just
    the soctypes, so checkpatch can validate DTSes.

 arch/arm/boot/dts/r8a7778.dtsi |   18 ++++++++++++------
 arch/arm/boot/dts/r8a7779.dtsi |   18 ++++++++++++------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 85c5b3b99f5e..3c6fab5c9702 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -204,26 +204,32 @@
 	};
 
 	hspi0: spi at fffc7000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi1: spi at fffc8000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi2: spi at fffc6000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4c7c46..8b1a336ee401 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -256,26 +256,32 @@
 	};
 
 	hspi0: spi at fffc7000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi1: spi at fffc8000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi2: spi at fffc6000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 };
-- 
1.7.9.5
