From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:33 +0900
Subject: [PATCH 05/33] ARM: shmobile: r8a7791 dtsi: Add MSIOF nodes and aliases
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <7713d3abe220c7d578768c07d183f6efbfa8895b.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6cda188..a70fb80 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -28,6 +28,9 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		spi0 = &qspi;
+		spi1 = &msiof0;
+		spi2 = &msiof1;
+		spi3 = &msiof2;
 	};
 
 	cpus {
@@ -800,4 +803,34 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	msiof0: spi at e6e20000 {
+		compatible = "renesas,msiof-r8a7791";
+		reg = <0 0xe6e20000 0 0x0064>;
+		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof1: spi at e6e10000 {
+		compatible = "renesas,msiof-r8a7791";
+		reg = <0 0xe6e10000 0 0x0064>;
+		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof2: spi at e6e00000 {
+		compatible = "renesas,msiof-r8a7791";
+		reg = <0 0xe6e00000 0 0x0064>;
+		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.8.5.2
