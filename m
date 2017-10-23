From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 23 Oct 2017 18:09:23 +0100
Subject: [PATCH v2 2/9] ARM: dts: iwg22d: Add /dev/ttySC5 support
In-Reply-To: <1508778570-28795-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1508778570-28795-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1508778570-28795-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for HSCIF1 as /dev/ttySC5, keeping the same naming
scheme adopted by iWave in their BSP release. This interface
uses RTS/CTS.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
Changes in v2:
* Added changelog

 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index edadeee..82587d7 100644
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
