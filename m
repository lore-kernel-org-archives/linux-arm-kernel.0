From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 31 May 2017 15:58:19 +0800
Subject: [PATCH v2 1/6] dt-bindings: clock: sunxi-ccu: Add pll-periph to
 PRCM's needed clocks
In-Reply-To: <20170531075824.657-1-wens@csie.org>
References: <20170531075824.657-1-wens@csie.org>
Message-ID: <20170531075824.657-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AR100 clock in the PRCM has parents, one of which is pll-periph from
the main CCU.

Add it to the list of required clocks for the PRCM CCU.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index 095a5807d874..966345972d83 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -25,7 +25,8 @@ Required properties :
 - #clock-cells : must contain 1
 - #reset-cells : must contain 1
 
-For the PRCM CCUs on A83T/H3/A64, one more clock is needed:
+For the PRCM CCUs on A83T/H3/A64, two more clock is needed:
+- "pll-periph": the SoC's peripheral PLL from the main CCU
 - "iosc": the SoC's internal frequency oscillator
 
 Example for generic CCU:
@@ -42,8 +43,8 @@ Example for PRCM CCU:
 r_ccu: clock at 01f01400 {
 	compatible = "allwinner,sun50i-a64-r-ccu";
 	reg = <0x01f01400 0x100>;
-	clocks = <&osc24M>, <&osc32k>, <&iosc>;
-	clock-names = "hosc", "losc", "iosc";
+	clocks = <&osc24M>, <&osc32k>, <&iosc>, <&ccu CLK_PLL_PERIPH0>;
+	clock-names = "hosc", "losc", "iosc", "pll-periph";
 	#clock-cells = <1>;
 	#reset-cells = <1>;
 };
-- 
2.11.0
