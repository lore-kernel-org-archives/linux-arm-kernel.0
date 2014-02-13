From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:46 +0900
Subject: [PATCH 1/3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
In-Reply-To: <cover.1392275963.git.horms+renesas@verge.net.au>
References: <cover.1392275963.git.horms+renesas@verge.net.au>
Message-ID: <4b18e83f5d77c783d2d2092d0015ccda5fecaa8c.1392275963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts |  2 +-
 arch/arm/boot/dts/r7s72100.dtsi                 | 75 +++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index da19c70..0849017 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "r7s72100.dtsi"
+#include "r7s72100.dtsi"
 
 / {
 	model = "Genmai";
diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 46b82aa..9be67a1 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -8,12 +8,22 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "renesas,r7s72100";
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -33,4 +43,69 @@
 		reg = <0xe8201000 0x1000>,
 			<0xe8202000 0x1000>;
 	};
+
+	spi0: spi at e800c800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800c800 0x24>;
+		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error", "rx", "tx";
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi1: spi at e800d000 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800d000 0x24>;
+		interrupts = <0 241 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 242 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error", "rx", "tx";
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi2: spi at e800d800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800d800 0x24>;
+		interrupts = <0 244 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 245 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error", "rx", "tx";
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi3: spi at e800e000 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800e000 0x24>;
+		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 248 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error", "rx", "tx";
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	spi4: spi at e800e800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800e800 0x24>;
+		interrupts = <0 250 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 251 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error", "rx", "tx";
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.8.5.2
