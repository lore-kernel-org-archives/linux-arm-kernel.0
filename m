From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Jun 2016 11:15:55 +0200
Subject: [PATCH 2/2] ARM: sun5i: Allow PLL3 2x fixed factor clock to change
 PLL3 rate
In-Reply-To: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
References: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
Message-ID: <20160622091555.18415-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to properly generate its pixel clock, the pll3-2x fixed
factor needs to be able to change the PLL3 rate too.

Add the needed extra compatible so that it behaves that way.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 0840612b5ed6..e374f4fc8073 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -130,7 +130,7 @@
 		};
 
 		pll3x2: pll3x2_clk {
-			compatible = "fixed-factor-clock";
+			compatible = "allwinner,sun4i-a10-pll3-2x-clk", "fixed-factor-clock";
 			#clock-cells = <0>;
 			clock-div = <1>;
 			clock-mult = <2>;
-- 
2.9.0
