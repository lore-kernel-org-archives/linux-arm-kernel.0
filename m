From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:47 +0900
Subject: [PATCH 10/15] ARM: shmobile: koelsch: Add DU external pixel clocks to
 DT
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <cd21cb46e14aae3a5d4f044c07f2c1f9d89fcd1a.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Declare the fixed 148.5MHz pixel clocks connected to the DU clock
inputs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 624bb2c..75fa985 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -269,6 +269,18 @@
 			};
 		};
 	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	x13_clk: x13-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
 };
 
 &du {
@@ -276,6 +288,13 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp7_clks R8A7791_CLK_DU0>,
+		 <&mstp7_clks R8A7791_CLK_DU1>,
+		 <&mstp7_clks R8A7791_CLK_LVDS0>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "lvds.0",
+		      "dclkin.0", "dclkin.1";
+
 	ports {
 		port at 0 {
 			endpoint {
-- 
2.1.4
