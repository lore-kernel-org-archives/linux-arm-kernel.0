From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Apr 2014 21:04:12 +0200
Subject: [PATCHv2 5/5] ARM: berlin/dt: add sdio clocks to BG2Q
In-Reply-To: <1398366252-19582-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398366252-19582-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398366252-19582-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sdio clocks to the berlin2q.dtsi
Also reorder the syspll node

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 5925e6a16749..559819b89ea1 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -102,13 +102,6 @@
 			reg = <0xdd0170 0x8>;
 		};
 
-		syspll: syspll at ea0030 {
-			compatible = "marvell,berlin2q-pll";
-			clocks = <&smclk>;
-			#clock-cells = <0>;
-			reg = <0xea0030 0x8>;
-		};
-
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -191,6 +184,27 @@
 			};
 		};
 
+		syspll: syspll at ea0030 {
+			compatible = "marvell,berlin2q-pll";
+			clocks = <&smclk>;
+			#clock-cells = <0>;
+			reg = <0xea0030 0x8>;
+		};
+
+		sdio0xinclk: sdio0xinclk at ea0158 {
+			compatible = "marvell,berlin-clk";
+			clocks = <&syspll>;
+			#clock-cells = <0>;
+			reg = <0xea0158 0x4>;
+		};
+
+		sdio1xinclk: sdio1xinclk at ea015c {
+			compatible = "marvell,berlin-clk";
+			clocks = <&syspll>;
+			#clock-cells = <0>;
+			reg = <0xea015c 0x4>;
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.1
