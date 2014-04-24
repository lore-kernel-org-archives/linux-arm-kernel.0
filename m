From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Apr 2014 21:04:10 +0200
Subject: [PATCHv2 3/5] ARM: berlin/dt: add sdio clocks to BG2
In-Reply-To: <1398366252-19582-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398366252-19582-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398366252-19582-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sdio clocks to the berlin2.dtsi
Also reorder the PLLs nodes by address

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 6c080eb6242a..2604c8692b77 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -86,20 +86,6 @@
 			clocks = <&twdclk>;
 		};
 
-		syspll: syspll at ea0014 {
-			compatible = "marvell,berlin2-pll";
-			clocks = <&smclk>;
-			#clock-cells = <0>;
-			reg = <0xea0014 8>;
-		};
-
-		cpupll: cpupll at ea003c {
-			compatible = "marvell,berlin2-pll";
-			clocks = <&smclk>;
-			#clock-cells = <0>;
-			reg = <0xea003c 8>;
-		};
-
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -190,6 +176,34 @@
 			};
 		};
 
+		syspll: syspll at ea0014 {
+			compatible = "marvell,berlin2-pll";
+			clocks = <&smclk>;
+			#clock-cells = <0>;
+			reg = <0xea0014 0x8>;
+		};
+
+		cpupll: cpupll at ea003c {
+			compatible = "marvell,berlin2-pll";
+			clocks = <&smclk>;
+			#clock-cells = <0>;
+			reg = <0xea003c 0x8>;
+		};
+
+		sdio0xinclk: sdio0xinclk at ea023c {
+			compatible = "marvell,berlin-clk";
+			clocks = <&syspll>;
+			#clock-cells = <0>;
+			reg = <0xea023c 0x4>;
+		};
+
+		sdio1xinclk: sdio1xinclk at ea0240 {
+			compatible = "marvell,berlin-clk";
+			clocks = <&syspll>;
+			#clock-cells = <0>;
+			reg = <0xea0240 0x4>;
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
