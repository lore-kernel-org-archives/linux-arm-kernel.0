From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Sep 2015 15:26:36 +0200
Subject: [PATCH 3/4] ARM: sun8i: Move A23 AHB1 gates out of common DTSI
In-Reply-To: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1441977997-29041-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AHB1 gates were assumed to be identical between the A23 and the A33,
which turned out to be wrong. Move the A23 gates definition to the A23
DTSI.

Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 -------------------------
 arch/arm/boot/dts/sun8i-a23.dtsi     | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 27a925ec17d2..a34bd5f49c2a 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -175,31 +175,6 @@
 			clock-output-names = "apb1";
 		};
 
-		ahb1_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb1>;
-			clock-indices = <1>, <6>,
-					<8>, <9>, <10>,
-					<13>, <14>,
-					<19>, <20>,
-					<21>, <24>, <26>,
-					<29>, <32>, <36>,
-					<40>, <44>, <46>,
-					<52>, <54>,
-					<57>;
-			clock-output-names = "ahb1_mipidsi", "ahb1_dma",
-					"ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
-					"ahb1_nand", "ahb1_sdram",
-					"ahb1_hstimer", "ahb1_spi0",
-					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
-					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
-					"ahb1_csi", "ahb1_be",	"ahb1_fe",
-					"ahb1_gpu", "ahb1_spinlock",
-					"ahb1_drc";
-		};
-
 		apb1_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun8i-a23-apb1-gates-clk";
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 2cc27c7a59dc..4a85e213843b 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -50,6 +50,31 @@
 	};
 
 	clocks {
+		ahb1_gates: clk at 01c20060 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
+			reg = <0x01c20060 0x8>;
+			clocks = <&ahb1>;
+			clock-indices = <1>, <6>,
+					<8>, <9>, <10>,
+					<13>, <14>,
+					<19>, <20>,
+					<21>, <24>, <26>,
+					<29>, <32>, <36>,
+					<40>, <44>, <46>,
+					<52>, <54>,
+					<57>;
+			clock-output-names = "ahb1_mipidsi", "ahb1_dma",
+					"ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
+					"ahb1_nand", "ahb1_sdram",
+					"ahb1_hstimer", "ahb1_spi0",
+					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
+					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
+					"ahb1_csi", "ahb1_be",	"ahb1_fe",
+					"ahb1_gpu", "ahb1_spinlock",
+					"ahb1_drc";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
-- 
2.5.1
