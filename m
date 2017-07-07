From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  7 Jul 2017 14:12:45 +0100
Subject: [PATCH v 2/2] ARM: dts: iwg20d-q7: Add Ethernet AVB support
In-Reply-To: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
References: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1499433165-62475-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the iWave RainboW-G20D-Qseven board dependent part of the Ethernet
AVB device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 497aec0..081af01 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -17,6 +17,7 @@
 
 	aliases {
 		serial0 = &scif0;
+		ethernet0 = &avb;
 	};
 };
 
@@ -25,6 +26,11 @@
 		groups = "scif0_data_d";
 		function = "scif0";
 	};
+
+	avb_pins: avb {
+		groups = "avb_mdio", "avb_gmii";
+		function = "avb";
+	};
 };
 
 &scif0 {
@@ -33,3 +39,18 @@
 
 	status = "okay";
 };
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy3>;
+	phy-mode = "gmii";
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+		micrel,led-mode = <1>;
+	};
+};
-- 
1.9.1
