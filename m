From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:23 +0100
Subject: [PATCH 28/61] ARM: dts: iwg20d-q7: Add support for ttySC3
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <77014a7c654c76e1c0cf82563cc48e07c546461c.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index efd8af9242d1..c865499ad2a1 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -11,6 +11,7 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		serial3 = &scifb1;
 		ethernet0 = &avb;
 	};
 
@@ -104,6 +105,11 @@
 		function = "scif0";
 	};
 
+	scifb1_pins: scifb1 {
+		groups = "scifb1_data_d", "scifb1_ctrl";
+		function = "scifb1";
+	};
+
 	sdhi1_pins: sd1 {
 		groups = "sdhi1_data4", "sdhi1_ctrl";
 		function = "sdhi1";
@@ -134,6 +140,14 @@
 	status = "okay";
 };
 
+&scifb1 {
+	pinctrl-0 = <&scifb1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.11.0
