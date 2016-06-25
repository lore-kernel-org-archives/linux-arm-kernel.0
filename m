From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:04 +0200
Subject: [PATCH v2 07/14] ARM: dts: sun8i: Use sun8i-h3-pll1-clk for pll1 in H3
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-8-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

PLL1 on H3 requires special factors application algorithm,
when the rate is changed. This algorithm was extracted
from the arisc code that handles frequency scaling
in the BSP kernel.

This algorithm is implemented by sun8i-h3-pll1-clk.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b..b3247f4 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -106,7 +106,7 @@
 
 		pll1: clk at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-pll1-clk";
+			compatible = "allwinner,sun8i-h3-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll1";
-- 
2.9.0
