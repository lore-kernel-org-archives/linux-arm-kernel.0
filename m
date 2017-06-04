From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  4 Jun 2017 14:31:15 -0300
Subject: [PATCH] ARM: dts: imx: Fix Ethernet PHY reset polarity
Message-ID: <1496597475-1361-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The FEC driver ignores the GPIO polarity from 'phy-reset-gpios' and
considers that the Ethernet PHY is active low, unless the
property 'phy-reset-active-high' is present.

Fix the device tree description by explicitly passing the 
'GPIO_ACTIVE_LOW' flag to the 'phy-reset-gpios' property.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts          | 2 +-
 arch/arm/boot/dts/imx25-pdk.dts                | 2 +-
 arch/arm/boot/dts/imx25.dtsi                   | 1 +
 arch/arm/boot/dts/imx28-cfa10037.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts           | 2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts   | 2 +-
 arch/arm/boot/dts/imx28-evk.dts                | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts             | 2 +-
 arch/arm/boot/dts/imx50-evk.dts                | 2 +-
 arch/arm/boot/dts/imx50.dtsi                   | 1 +
 arch/arm/boot/dts/imx51-apf51.dts              | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts              | 2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi        | 2 +-
 arch/arm/boot/dts/imx53-smd.dts                | 2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi              | 2 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi    | 2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts         | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts        | 2 +-
 arch/arm/boot/dts/imx6q-evi.dts                | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts           | 2 +-
 arch/arm/boot/dts/imx6q-novena.dts             | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi    | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi         | 2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi             | 2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       | 2 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts   | 2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi            | 4 ++--
 32 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 9b31faa..30a62d4 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -97,7 +97,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
-	phy-reset-gpios = <&gpio3 7 0>;
+	phy-reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
 	phy-mode = "rmii";
 	phy-supply = <&reg_fec_phy>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index d921dd2..c526928 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -125,7 +125,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-supply = <&reg_fec_3v3>;
-	phy-reset-gpios = <&gpio4 8 0>;
+	phy-reset-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 0cdf333..dfcc8e0 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "imx25-pinfunc.h"
 
 / {
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index e5beaa5..3d13b32 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -64,7 +64,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10037>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a9c347e..4cd52d5 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -327,7 +327,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10049>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 7a80bd6..c606791 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -162,7 +162,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index f5c6dce..70c7bb4 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -129,7 +129,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
index e773144..b61fd61 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
@@ -31,7 +31,7 @@
 	phy-mode = "rmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mac1_pins_a>;
-	phy-reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 27 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index a5ba669..a894cb8 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -262,7 +262,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
 			phy-supply = <&reg_fec_3v3>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index bb53294..9d6c8fe 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -188,7 +188,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index dba2d95..98b5faa 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -53,7 +53,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 12 0>;
+	phy-reset-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 2a98afc..3747d80 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -12,6 +12,7 @@
  */
 
 #include "imx50-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/imx5-clock.h>
 
 / {
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index e88b2a6..c83ac16 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -36,7 +36,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "mii";
-	phy-reset-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 2e44d2a..df705ba 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -195,7 +195,7 @@
 };
 
 &fec {
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 40b3e31..683dcbe 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -344,7 +344,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 472f6f0..33cb64f 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -273,6 +273,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 3a32201..7807c1f 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -201,7 +201,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	phy-handle = <&phy0>;
 	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index 524192c..df8dafe 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -137,7 +137,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 2 0>;
+	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 2cb7282..29b45f2 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -94,7 +94,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 31 0>;
+	phy-reset-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
 	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	fsl,err006687-workaround-present;
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index f28883b..0c5b2c3 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -118,7 +118,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	phy-supply = <&vgen2_1v2_eth>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index fd2220a..1f0f950 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -135,7 +135,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	fsl,err006687-workaround-present;
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 687ab91..9dbeea0 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -153,7 +153,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 0fa32b2..c21db67 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -217,7 +217,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_novena>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	rxc-skew-ps = <3000>;
 	rxdv-skew-ps = <0>;
 	txc-skew-ps = <3000>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index b2debc0..7d64075 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -118,7 +118,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index ec68f1c..ed6a89f 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -320,7 +320,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio7 18 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 18 GPIO_ACTIVE_LOW>;
 	txd0-skew-ps = <0>;
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index a9b2077..900e8c7 100644
--- a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
@@ -46,7 +46,7 @@
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
 	phy-mode = "rgmii";
 	phy-reset-duration = <2>;
-	phy-reset-gpios = <&gpio4 15 0>;
+	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 70772eb..f22e587 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -271,7 +271,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 27 0>;
+	phy-reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
 	txen-skew-ps = <0>;
 	txc-skew-ps = <3000>;
 	rxdv-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 58055ce..db705f1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -178,7 +178,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 1691714..32ad581 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -249,7 +249,7 @@
 		 <&clks IMX6QDL_CLK_ENET_REF>;
 	clock-names = "ipg", "ahb", "ptp", "enet_out";
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	phy-handle = <&etnphy>;
 	phy-supply = <&reg_3v3_etn>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 850cead..b4fa7f1 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -209,7 +209,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 29 0>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	fsl,err006687-workaround-present;
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
index 7c5dd1b..28d055e 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
+++ b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
@@ -78,7 +78,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio &pinctrl_etnphy1_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index c784a0b..1c6e09b 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -308,7 +308,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy0>;
 	status = "okay";
@@ -343,7 +343,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2 &pinctrl_etnphy1_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy1>;
 	status = "disabled";
-- 
2.7.4
