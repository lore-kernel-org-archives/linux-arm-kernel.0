From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:32 +0200
Subject: [PATCH 59/69] ARM: dts: r7s72100: Correct RTC interrupt types
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <cad8e5a7a1e27e9efe4e706ace75e0826a79707f.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to table 7.3 ("List of Interrupt IDs") in the RZ/A1H Hardware
User's Manual rev. 3.00, the realtime clock interrupts are level not
edge interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index c7b3dca6d81c..eb2e6f95a2e8 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -682,9 +682,9 @@
 		rtc: rtc at fcff1000 {
 			compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
 			reg = <0xfcff1000 0x2e>;
-			interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
-				      GIC_SPI 277 IRQ_TYPE_EDGE_RISING
-				      GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "alarm", "period", "carry";
 			clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
 				 <&rtc_x3_clk>, <&extal_clk>;
-- 
2.11.0
