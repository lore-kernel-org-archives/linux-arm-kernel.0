From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:52 +0100
Subject: [PATCH 62/68] ARM: dts: bockw: Enable SCIF_CLK frequency and pins
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <33ef9688ae45d19bf11c75a7c403a4f20804720d.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index a52b359e2ae2..21e3b9dda2da 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -126,11 +126,19 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk";
+		renesas,function = "scif_clk";
+	};
+
 	mmc_pins: mmc {
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
@@ -217,3 +225,8 @@
 
 	status = "okay";
 };
+
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
