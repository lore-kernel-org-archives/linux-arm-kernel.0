From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 13 Oct 2017 14:03:14 +0100
Subject: [PATCH 2/4] ARM: dts: iwg22d: Add /dev/ttySC5 support
In-Reply-To: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1507899796-7941-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index edda4f1..5d5bb2f 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -17,6 +17,7 @@
 
 	aliases {
 		serial3 = &scif4;
+		serial5 = &hscif1;
 		ethernet0 = &avb;
 	};
 
@@ -39,7 +40,20 @@
 	};
 };
 
+&hscif1 {
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &pfc {
+	hscif1_pins: hscif1 {
+		groups = "hscif1_data", "hscif1_ctrl";
+		function = "hscif1";
+	};
+
 	scif4_pins: scif4 {
 		groups = "scif4_data_b";
 		function = "scif4";
-- 
2.7.4
