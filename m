From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:13 +0200
Subject: [PATCH 21/48] ARM: dts: gr-peach: Add SCIF2 pin group
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <2f8be2d1dadb2b73a1c1ce244c88c509791f5cf2.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add pin configuration subnode for SCIF2 serial debug interface.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index 1c40a1afbd8e..bcfa6445bbaa 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r7s72100.dtsi"
+#include <dt-bindings/pinctrl/r7s72100-pinctrl.h>
 
 / {
 	model = "GR-Peach";
@@ -52,6 +53,13 @@
 	};
 };
 
+&pinctrl {
+	scif2_pins: serial2 {
+		/* P6_2 as RxD2; P6_3 as TxD2 */
+		pinmux = <RZA1_PINMUX(6, 2, 7)>, <RZA1_PINMUX(6, 3, 7)>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <13333000>;
 };
@@ -61,5 +69,8 @@
 };
 
 &scif2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif2_pins>;
+
 	status = "okay";
 };
-- 
2.1.4
