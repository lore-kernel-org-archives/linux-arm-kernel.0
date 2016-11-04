From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:03 +0100
Subject: [PATCH 08/12] arm64: dts: r8a7796: salvator-x: enable UHS for SDHI 0
 & 3
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <af3cf72f5f4b158d34935d6995908989afbe756c.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work for the r8a7796 by Wolfram Sang.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c946569accb1..08c335afd970 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -97,11 +97,25 @@
 	sdhi0_pins: sd0 {
 		groups = "sdhi0_data4", "sdhi0_ctrl";
 		function = "sdhi0";
+		power-source = <3300>;
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <1800>;
 	};
 
 	sdhi3_pins: sd3 {
 		groups = "sdhi3_data4", "sdhi3_ctrl";
 		function = "sdhi3";
+		power-source = <3300>;
+	};
+
+	sdhi3_pins_uhs: sd3_uhs {
+		groups = "sdhi3_data4", "sdhi3_ctrl";
+		function = "sdhi3";
+		power-source = <1800>;
 	};
 };
 
@@ -115,25 +129,29 @@
 
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
 &sdhi3 {
 	pinctrl-0 = <&sdhi3_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi3_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&vcc_sdhi3>;
 	vqmmc-supply = <&vccq_sdhi3>;
 	cd-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
 	bus-width = <4>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
