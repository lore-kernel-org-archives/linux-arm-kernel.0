From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:32 +0100
Subject: [PATCH 37/61] ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera
 DB
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <04e31b155f628e572d4ee2eeda5d6ee20ba86038.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

CAN1 interface is exposed via connector J3 found on the camera daughter
board. This patch enables can1 DT node from within the daughter board
specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
index 4db18f2ef303..476273b3f994 100644
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
2.11.0
