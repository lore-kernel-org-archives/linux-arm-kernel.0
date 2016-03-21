From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:01:02 +0100
Subject: [linux-sunxi][PATCH v3 4/8] ARM: dts: sun7i: Add the SPDIF clk to the
 A20
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-5-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF clock to the A20 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0c207d0..108cad4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -476,6 +476,17 @@
 			clock-output-names = "ir1";
 		};
 
+		spdif_clk: clk at 01c200c0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod1-clk";
+			reg = <0x01c200c0 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
+				 <&pll2 SUN4I_A10_PLL2_4X>,
+				 <&pll2 SUN4I_A10_PLL2_2X>,
+				 <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "spdif";
+		};
+
 		keypad_clk: clk at 01c200c4 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
-- 
2.7.4
