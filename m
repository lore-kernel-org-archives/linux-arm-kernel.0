From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Apr 2017 16:34:47 +0900
Subject: [PATCH/RFT v2] ARM: dts: silk: Enable UHS-I SDR-50
Message-ID: <1492500887-20084-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile tested only; no access to silk board
---
 arch/arm/boot/dts/r8a7794-silk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 4cb5278d104d..bb0c41c2f3ac 100644
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
@@ -343,6 +350,7 @@
 	vmmc-supply = <&vcc_sdhi1>;
 	vqmmc-supply = <&vccq_sdhi1>;
 	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344
