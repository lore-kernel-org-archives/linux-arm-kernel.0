From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:34 +0200
Subject: [PATCH 01/35] arm64: dts: m3ulcb: enable I2C
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <82c906fac243f1a5d99867551c0933aee414bfbb.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>

This supports I2C2 bus on M3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov+renesas@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 372b2a944716..5554b555b874 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -120,6 +120,11 @@
 		function = "scif_clk";
 	};
 
+	i2c2_pins: i2c2 {
+		groups = "i2c2_a";
+		function = "i2c2";
+	};
+
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
@@ -182,6 +187,13 @@
 	clock-frequency = <14745600>;
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &wdt0 {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.1.4
