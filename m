From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  7 Nov 2017 15:10:48 +0000
Subject: [PATCH 7/8] ARM: dts: iwg20d-q7-common: Add can0 support to carrier
 board
In-Reply-To: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1510067449-17017-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables CAN0 interface exposed through connector J20 on the
carrier board.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index c865499..3e4bc4d 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -59,6 +59,13 @@
 	};
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &hsusb {
 	status = "okay";
 	pinctrl-0 = <&usb0_pins>;
@@ -90,6 +97,11 @@
 };
 
 &pfc {
+	can0_pins: can0 {
+		groups = "can0_data_d";
+		function = "can0";
+	};
+
 	avb_pins: avb {
 		groups = "avb_mdio", "avb_gmii";
 		function = "avb";
-- 
2.7.4
