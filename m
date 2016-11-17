From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:04:47 +0100
Subject: [PATCH 08/18] arm64: dts: m3ulcb: enable SCIF clk and pins
In-Reply-To: <cover.1479388193.git.horms+renesas@verge.net.au>
References: <cover.1479388193.git.horms+renesas@verge.net.au>
Message-ID: <ad3f85a9b6c5f14f67a906ce04f57ca5adec096e.1479388193.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This enables the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 1ae0708bb495..96cda59c2698 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -37,10 +37,18 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
 	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_a";
+		function = "scif_clk";
+	};
 };
 
 &scif2 {
@@ -49,3 +57,8 @@
 
 	status = "okay";
 };
+
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
-- 
2.7.0.rc3.207.g0ac5344
