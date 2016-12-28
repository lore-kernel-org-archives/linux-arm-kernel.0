From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 29 Dec 2016 00:35:07 +0300
Subject: [PATCH] ARM: dts: r8a7794: link DU to VSPD
In-Reply-To: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
Message-ID: <1524349.7vYNCWaVjE@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "vsps" property to the DU device node in order to link this node to
the (single) VSPD node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20161220-v4.9' of Simon Horman's
'renesas.git' repo.  It's  only meaningful if the "Enable R8A7794 DU VSPD
compositor" DU driver patches are applied...

 arch/arm/boot/dts/r8a7794.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -908,7 +908,7 @@
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
-	vsp1 at fe930000 {
+	vspd0: vsp1 at fe930000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
@@ -925,6 +925,7 @@
 		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
 			 <&mstp7_clks R8A7794_CLK_DU0>;
 		clock-names = "du.0", "du.1";
+		vsps = <&vspd0>;
 		status = "disabled";
 
 		ports {
