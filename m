From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:46 +0900
Subject: [PATCH 09/15] ARM: shmobile: marzen: Add DU external pixel clock to DT
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <665d79aa47cb3983b1fd14cd7c42eead5324c24e.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Declare the fixed 65MHz pixel clock connected to the DU clock input.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index e83d40e..540756c 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -122,6 +122,12 @@
 			};
 		};
 	};
+
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <65000000>;
+	};
 };
 
 &du {
@@ -129,6 +135,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp1_clks R8A7779_CLK_DU>, <&x3_clk>;
+	clock-names = "du", "dclkin.0";
+
 	ports {
 		port at 0 {
 			endpoint {
-- 
2.1.4
