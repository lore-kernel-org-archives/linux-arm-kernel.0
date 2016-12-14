From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 15 Dec 2016 01:07:52 +0300
Subject: [PATCH] ARM: dts: r8a7791: link DU to VSPDs
In-Reply-To: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
Message-ID: <1922293.x1RvWWSErN@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "vsps" property to the DU device node in order to link this node to
the VSPD nodes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20161212-v4.9' of Simon Horman's
'renesas.git' repo.  It's  only meaningful if the DU driver patch I've just
posted is applied.

 arch/arm/boot/dts/r8a7791.dtsi |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -989,7 +989,7 @@
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
-	vsp1 at fe930000 {
+	vspd0: vsp1 at fe930000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
@@ -997,7 +997,7 @@
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
-	vsp1 at fe938000 {
+	vspd1: vsp1 at fe938000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
@@ -1016,6 +1016,7 @@
 			 <&mstp7_clks R8A7791_CLK_DU1>,
 			 <&mstp7_clks R8A7791_CLK_LVDS0>;
 		clock-names = "du.0", "du.1", "lvds.0";
+		vsps = <&vspd0 &vspd1>;
 		status = "disabled";
 
 		ports {
