From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:23 +0200
Subject: [PATCH 28/29] arm64: dts: renesas: salvator-common: Add HSCIF1 device
 support
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <b6d3134ddcbe4d3c3986e4e7b649467a19045949.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

This patch adds pin control for HSCIF1, and supports connection with
Debug Serial-1 (CN26) on Salvator boards.

SCIF1 and HSCIF1 are sharing the pins connected to Debug Serial-1 (CN26)
on Salvator boards, and it is necessary to ensure that either SCIF1 or
HSCIF1 is enabled, not both.

As for the default of this DeviceTree, SCIF1 is connected.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Add missing "uart-has-rtscts"]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 320250d708c3..ce808d3f9f62 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -338,6 +338,15 @@
 	clock-frequency = <32768>;
 };
 
+&hscif1 {
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	/* Please only enable hscif1 or scif1 */
+	/* status = "okay"; */
+};
+
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
@@ -543,6 +552,11 @@
 		function = "du";
 	};
 
+	hscif1_pins: hscif1 {
+		groups = "hscif1_data_a", "hscif1_ctrl_a";
+		function = "hscif1";
+	};
+
 	i2c2_pins: i2c2 {
 		groups = "i2c2_a";
 		function = "i2c2";
@@ -708,6 +722,7 @@
 	pinctrl-names = "default";
 
 	uart-has-rtscts;
+	/* Please only enable hscif1 or scif1 */
 	status = "okay";
 };
 
-- 
2.11.0
