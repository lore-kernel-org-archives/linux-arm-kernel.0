From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  9 Oct 2017 10:06:21 +0100
Subject: [PATCH] ARM: dts: iwg20d-q7: Add support for ttySC3
Message-ID: <1507539981-4193-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 1c072c0..8c852d1 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -11,6 +11,7 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		serial3 = &scifb1;
 		ethernet0 = &avb;
 	};
 
@@ -99,6 +100,11 @@
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
@@ -129,6 +135,14 @@
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
2.7.4
