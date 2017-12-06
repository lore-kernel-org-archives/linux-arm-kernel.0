From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:06 +0100
Subject: [PATCH 11/61] ARM: dts: iwg22d: Add /dev/ttySC5 support
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <c7a5ddfbf171c222772087ba8697b163e8785caa.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add support for HSCIF1 as /dev/ttySC5, keeping the same naming
scheme adopted by iWave in their BSP release. This interface
uses RTS/CTS.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index edadeee8f1ec..82587d7b2056 100644
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
2.11.0
