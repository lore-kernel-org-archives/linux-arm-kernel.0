From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Aug 2016 00:52:58 +0300
Subject: [PATCH] ARM: dts: r8a7794: add VSP1 support
In-Reply-To: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
References: <1618499.8bcj8adpVO@wasted.cogentembedded.com>
Message-ID: <2191193.axSzE4vSGB@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe two instances (VSPS and VSPD0) of the VSP1 in the R8A7794 device
tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160815-v4.8-rc2' of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7794.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -894,6 +894,22 @@
 		};
 	};
 
+	vsp1 at fe928000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe928000 0 0x8000>;
+		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7794_CLK_VSP1_S>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+	};
+
+	vsp1 at fe930000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe930000 0 0x8000>;
+		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7794_CLK_VSP1_DU0>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+	};
+
 	du: display at feb00000 {
 		compatible = "renesas,du-r8a7794";
 		reg = <0 0xfeb00000 0 0x40000>;
