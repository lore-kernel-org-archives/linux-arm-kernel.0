From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:39 +1000
Subject: [PATCH 21/22] ARM: dts: r8a7793: Add SDHI controllers
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <fc9ee228f5005437b9fdb1b85804b6d3f8d497be.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Same as on r8a7791.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index bddc31283bd9..6186179fd66d 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -507,6 +507,39 @@
 		reg = <0 0xe6060000 0 0x250>;
 	};
 
+	sdhi0: sd at ee100000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee100000 0 0x328>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi1: sd at ee140000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee140000 0 0x100>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	sdhi2: sd at ee160000 {
+		compatible = "renesas,sdhi-r8a7793";
+		reg = <0 0xee160000 0 0x100>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7793",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";
-- 
2.7.0.rc3.207.g0ac5344
