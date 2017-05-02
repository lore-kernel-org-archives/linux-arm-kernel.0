From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 May 2017 10:43:25 +0200
Subject: [PATCH/RFT v4 renesas-devel] ARM: dts: silk: Enable UHS-I SDR-50
Message-ID: <1493714605-4123-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Prepared on top of renesas-devel-20170501-v4.11
* Compile tested only; no access to silk board

v4
* Use sdhi1_pins_uhs rather than sdhi0_pins_uhs

v3
* Added missing pinctrl-1 to sdhi0

v2
* Correct mangled addition of sdhi*_pins
---
 arch/arm/boot/dts/r8a7794-silk.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 4cb5278d104d..824a5bfb2151 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -196,6 +196,13 @@
 	sdhi1_pins: sd1 {
 		groups = "sdhi1_data4", "sdhi1_ctrl";
 		function = "sdhi1";
+		power-source = <3300>;
+	};
+
+	sdhi1_pins_uhs: sd1_uhs {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <1800>;
 	};
 
 	qspi_pins: qspi {
@@ -338,11 +345,13 @@
 
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
 
 	vmmc-supply = <&vcc_sdhi1>;
 	vqmmc-supply = <&vccq_sdhi1>;
 	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.1.4
