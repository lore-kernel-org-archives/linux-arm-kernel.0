From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:45 +0200
Subject: [PATCH 26/26] ARM: dts: r8a7792: add DU support
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <8bec0842ba2bb1b3bd954a1ef50f426b8f09c84f.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7792 part of the DU device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 7e0c57ff9892..9763289db5ce 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -556,6 +556,34 @@
 			status = "disabled";
 		};
 
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a7792";
+			reg = <0 0xfeb00000 0 0x40000>;
+			reg-names = "du";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7792_CLK_DU0>,
+				 <&mstp7_clks R8A7792_CLK_DU1>;
+			clock-names = "du.0", "du.1";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb0: endpoint {
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					du_out_rgb1: endpoint {
+					};
+				};
+			};
+		};
+
 		can0: can at e6e80000 {
 			compatible = "renesas,can-r8a7792",
 				     "renesas,rcar-gen2-can";
-- 
2.7.0.rc3.207.g0ac5344
