From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:22 +0800
Subject: [PATCH v2 4/6] ARM: sunxi: h3-h5: Add PLL_PERIPH0 clock to the R_CCU
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531075824.657-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AR100 clock within the R_CCU (PRCM) has the PLL_PERIPH0 as one of
its parents.

This adds the reference in the device tree describing this relationship.
This patch uses a raw number for the clock index to ease merging by
avoiding cross tree dependencies.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index d0067fec99de..d4f600dbb7eb 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -560,8 +560,9 @@
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>;
-			clock-names = "hosc", "losc", "iosc";
+			clocks = <&osc24M>, <&osc32k>, <&iosc>,
+				 <&ccu 9>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
-- 
2.11.0
