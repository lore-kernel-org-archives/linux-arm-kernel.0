From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Sep 2015 15:26:35 +0200
Subject: [PATCH 2/4] ARM: sun8i: Add the A33 AHB1 gates clock driver
In-Reply-To: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1441977997-29041-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 has different a different gates array than the A23, add the node to
the DT.

Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index faa7d3c1fcea..3457edb3bf50 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -72,6 +72,33 @@
 			clock-output-names = "pll11";
 		};
 
+		ahb1_gates: clk at 01c20060 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun8i-a33-ahb1-gates-clk";
+			reg = <0x01c20060 0x8>;
+			clocks = <&ahb1>;
+			clock-indices = <1>, <5>,
+				        <6>, <8>, <9>,
+				        <10>, <13>, <14>,
+					<19>, <20>,
+					<21>, <24>, <26>,
+					<29>, <32>, <36>,
+					<40>, <44>, <46>,
+					<52>, <53>,
+					<54>, <57>,
+					<58>;
+			clock-output-names = "ahb1_mipidsi", "ahb1_ss",
+					"ahb1_dma","ahb1_mmc0", "ahb1_mmc1",
+					"ahb1_mmc2", "ahb1_nand", "ahb1_sdram",
+					"ahb1_hstimer", "ahb1_spi0",
+					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
+					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
+					"ahb1_csi", "ahb1_be",	"ahb1_fe",
+					"ahb1_gpu", "ahb1_msgbox",
+					"ahb1_spinlock", "ahb1_drc",
+					"ahb1_sat";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun8i-a23-mbus-clk";
-- 
2.5.1
