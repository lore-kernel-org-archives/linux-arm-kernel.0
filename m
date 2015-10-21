From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Oct 2015 22:52:55 +0200
Subject: [PATCH 02/13] ARM: sun5i: Add audio PLL
In-Reply-To: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445460786-18280-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1445460786-18280-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A13 uses the PLL2 as the audio PLL, which is the parent of all the
other audio clocks in the system (i2s, codec, etc.). However, it has a
different divider configuration than the A10, hence the difference
compatible.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 9ffee9bb70a7..9b03eb95a390 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -102,6 +102,15 @@
 			clock-output-names = "pll1";
 		};
 
+		pll2: clk at 01c20008 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun5i-a13-pll2-clk";
+			reg = <0x01c20008 0x8>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll2-1x", "pll2-2x",
+					     "pll2-4x", "pll2-8x";
+		};
+
 		pll4: clk at 01c20018 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-pll1-clk";
-- 
2.6.2
