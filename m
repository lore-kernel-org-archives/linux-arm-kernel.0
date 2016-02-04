From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:45 +0100
Subject: [PATCH 8/8] arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins
In-Reply-To: <cover.1454595726.git.horms+renesas@verge.net.au>
References: <cover.1454595726.git.horms+renesas@verge.net.au>
Message-ID: <a3fc85e27b7e3c29b30909929bc64737a19fd251.1454595726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates:
  - SCIF:
      - Supports now 50, 230400, 460800, 500000, and 921600 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.
  - HSCIF:
      - Supports now 50, 75, and 110 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 9af1e3fdc468..31ace9c1f79d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -93,6 +93,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif1_pins: scif1 {
 		renesas,groups = "scif1_data_a", "scif1_ctrl";
 		renesas,function = "scif1";
@@ -101,6 +104,10 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk_a";
+		renesas,function = "scif_clk";
+	};
 
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2_a";
@@ -138,6 +145,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
-- 
2.7.0.rc3.207.g0ac5344
