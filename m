From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:48 +0200
Subject: [PATCH 15/69] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
In-Reply-To: <cover.1526641667.git.horms+renesas@verge.net.au>
References: <cover.1526641667.git.horms+renesas@verge.net.au>
Message-ID: <f558d42a9d1c4724a8b3880fe230a66fa16e21c8.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add Capture Engine Unit (CEU) node to device tree.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
[simon: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index ecf9516bcda8..4a1aade0e751 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -375,6 +375,15 @@
 			status = "disabled";
 		};
 
+		ceu: camera at e8210000 {
+			reg = <0xe8210000 0x3000>;
+			compatible = "renesas,r7s72100-ceu";
+			interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp6_clks R7S72100_CLK_CEU>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		wdt: watchdog at fcfe0000 {
 			compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
 			reg = <0xfcfe0000 0x6>;
@@ -429,9 +438,9 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe042c 4>;
-			clocks = <&p0_clk>;
-			clock-indices = <R7S72100_CLK_RTC>;
-			clock-output-names = "rtc";
+			clocks = <&b_clk>, <&p0_clk>;
+			clock-indices = <R7S72100_CLK_CEU R7S72100_CLK_RTC>;
+			clock-output-names = "ceu", "rtc";
 		};
 
 		mstp7_clks: mstp7_clks at fcfe0430 {
-- 
2.11.0
