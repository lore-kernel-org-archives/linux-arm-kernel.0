From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:49:48 +0200
Subject: [PATCH 01/26] ARM: dts: r8a7794: add VSP1 support
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <bb249cdc3e55b099c05cd350772368ae85592706.1473234371.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe two instances (VSPS and VSPD0) of the VSP1 in the R8A7794 device
tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6216a170a3df..611ec6df5cf6 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
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
-- 
2.7.0.rc3.207.g0ac5344
