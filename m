From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:36 +0900
Subject: [PATCH 04/47] ARM: dts: r8a7790: Add SCIF2 device node
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <c18ce360ef6c97a00e7c95c60deb1e56e7bd7e14.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index cc4974a348d9..b2d6a0f6105c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -732,6 +732,20 @@
 		status = "disabled";
 	};
 
+	scif2: serial at e6e56000 {
+		compatible = "renesas,scif-r8a7790", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
+		reg = <0 0xe6e56000 0 64>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	hscif0: serial at e62c0000 {
 		compatible = "renesas,hscif-r8a7790",
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
-- 
2.1.4
