From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:01:01 +0100
Subject: [linux-sunxi][PATCH v3 3/8] ARM: dts: sun4i: Add the SPDIF clk to the
 A10
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-4-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF clock to the A10 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 62fcef9..5747522 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -477,6 +477,17 @@
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
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.7.4
