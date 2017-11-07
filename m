From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  7 Nov 2017 15:10:49 +0000
Subject: [PATCH 8/8] ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera DB
In-Reply-To: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1510067449-17017-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CAN1 interface is exposed via connector J3 found on the camera daughter
board. This patch enables can1 DT node from within the daughter board
specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
index 4db18f2..476273b 100644
--- a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
@@ -32,6 +32,13 @@
 	};
 };
 
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &du {
 	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
@@ -94,6 +101,11 @@
 };
 
 &pfc {
+	can1_pins: can1 {
+		groups = "can1_data_d";
+		function = "can1";
+	};
+
 	du_pins: du {
 		groups = "du_rgb888", "du_sync", "du_oddf", "du_clk_out_0";
 		function = "du";
-- 
2.7.4
