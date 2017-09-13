From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 13 Sep 2017 18:05:36 +0100
Subject: [PATCH 3/8] ARM: dts: iwg22m: Enable SDHI1 controller
In-Reply-To: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1505322341-9480-4-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Enable the SDHI1 controller on iWave RZ/G1E SoM.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
This patch is based on renesas-devel-20170913-v4.13.


 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index e306e7c..f7f9cef 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "r8a7745.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "iwave,g22m", "renesas,r8a7745";
@@ -38,6 +39,12 @@
 		function = "mmc";
 	};
 
+	sdhi1_pins: sd1 {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <3300>;
+	};
+
 	i2c3_pins: i2c3 {
 		groups = "i2c3_b";
 		function = "i2c3";
@@ -54,6 +61,16 @@
 	status = "okay";
 };
 
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
-- 
1.9.1
