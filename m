From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:32 +0900
Subject: [PATCH 02/25] ARM: shmobile: sh73a0: Add MSIOF device nodes
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <d74f61fee39d5896913d268b60884b13b43edee7.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The sh73a0 has 4 MSIOF devices, located in the A3SP power area.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 635564ab98ed..3a6056f9f0d2 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -273,6 +273,50 @@
 		status = "disabled";
 	};
 
+	msiof0: spi at e6e20000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e20000 0x0064>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks SH73A0_CLK_MSIOF0>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof1: spi at e6e10000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e10000 0x0064>;
+		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF1>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof2: spi at e6e00000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e00000 0x0064>;
+		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF2>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof3: spi at e6c90000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6c90000 0x0064>;
+		interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF3>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
-- 
2.1.4
