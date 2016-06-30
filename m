From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:49 +0200
Subject: [PATCH 29/41] ARM: dts: silk: add DU pins
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <adc47ecf5a8d35f8060c88ac818cd5404268f3ed.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the (previously omitted) DU pin data to the SILK board's device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 488de730bee8..cf24f45fff22 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -183,6 +183,16 @@
 		groups = "usb1";
 		function = "usb1";
 	};
+
+	du0_pins: du0 {
+		groups = "du0_rgb888", "du0_sync", "du0_disp", "du0_clk0_out";
+		function = "du0";
+	};
+
+	du1_pins: du1 {
+		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_clk0_out";
+		function = "du1";
+	};
 };
 
 &scif2 {
@@ -360,6 +370,8 @@
 };
 
 &du {
+	pinctrl-0 = <&du0_pins &du1_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
-- 
2.7.0.rc3.207.g0ac5344
