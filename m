From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:48 +0900
Subject: [PATCH 11/15] ARM: shmobile: lager: Add DU external pixel clocks to DT
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <26c00ab4aae2d29b6c724a9c23d5f6cba2b20e41.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Declare the fixed 148.5MHz pixel clocks connected to the DU clock
inputs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 631b3f5..329bb99 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -233,6 +233,18 @@
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
@@ -240,6 +252,15 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+		 <&mstp7_clks R8A7790_CLK_DU1>,
+		 <&mstp7_clks R8A7790_CLK_DU2>,
+		 <&mstp7_clks R8A7790_CLK_LVDS0>,
+		 <&mstp7_clks R8A7790_CLK_LVDS1>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1",
+		      "dclkin.0", "dclkin.1";
+
 	ports {
 		port at 0 {
 			endpoint {
-- 
2.1.4
