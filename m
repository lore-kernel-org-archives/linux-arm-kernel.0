From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 14 Aug 2017 12:49:48 +0100
Subject: [PATCH  2/3] ARM: dts: iwg20m: Enable SDHI0 controller
In-Reply-To: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502711389-16040-3-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SDHI0 controller on iWave RZG1M Qseven SOM.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index ff79938..4119737 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "r8a7743.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "iwave,g20m", "renesas,r8a7743";
@@ -42,6 +43,12 @@
 		groups = "mmc_data8_b", "mmc_ctrl";
 		function = "mmc";
 	};
+
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <3300>;
+	};
 };
 
 &mmcif0 {
@@ -53,3 +60,13 @@
 	non-removable;
 	status = "okay";
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
-- 
1.9.1
