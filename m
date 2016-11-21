From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Nov 2016 13:05:32 +0100
Subject: [PATCH 03/18] arm64: dts: r8a7796: salvator-x: enable I2C
In-Reply-To: <cover.1479726397.git.horms+renesas@verge.net.au>
References: <cover.1479726397.git.horms+renesas@verge.net.au>
Message-ID: <20b93fbb08bd38f094186f604e4e5bdafe23f817.1479726397.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index a9c296b1e1b7..f35e96ca7d60 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -111,6 +111,11 @@
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
@@ -208,6 +213,13 @@
 	status = "okay";
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
2.7.0.rc3.207.g0ac5344
