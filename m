From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat,  9 Jul 2016 00:41:24 +0200
Subject: [PATCH] ARM: dts: imx: fix polarity of fec reset gpios
Message-ID: <1468017684-3179-1-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fec driver ignores the polarity flags of the references in
phy-reset-gpios and assumes them to be active low unlesss there is a
property phy-reset-active-high.

So fix all device trees that specify (maybe implicitly) an active high
gpio without the phy-reset-active-high property.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts          |  5 ++++-
 arch/arm/boot/dts/imx25-pdk.dts                |  2 +-
 arch/arm/boot/dts/imx50-evk.dts                |  5 ++++-
 arch/arm/boot/dts/imx51-apf51.dts              |  2 +-
 arch/arm/boot/dts/imx53-mba53.dts              |  2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi        |  2 +-
 arch/arm/boot/dts/imx53-smd.dts                |  2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi              |  2 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi    |  2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts         |  2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts        |  2 +-
 arch/arm/boot/dts/imx6q-evi.dts                |  2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts           |  2 +-
 arch/arm/boot/dts/imx6q-novena.dts             |  2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi    |  2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi   |  2 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi      |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi         |  2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi             |  2 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       |  2 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts   |  2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi            |  4 ++--
 25 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 9b31faa96377..02ad47318820 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -10,6 +10,9 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
 #include "imx25.dtsi"
 
 / {
@@ -97,7 +100,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
-	phy-reset-gpios = <&gpio3 7 0>;
+	phy-reset-gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
 	phy-mode = "rmii";
 	phy-supply = <&reg_fec_phy>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 9351296356dc..b690ce15c793 100644
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
 
diff --git a/arch/arm/boot/dts/imx50-evk.dts b/arch/arm/boot/dts/imx50-evk.dts
index 27d763c7a307..15fe67ced45f 100644
--- a/arch/arm/boot/dts/imx50-evk.dts
+++ b/arch/arm/boot/dts/imx50-evk.dts
@@ -12,6 +12,9 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
 #include "imx50.dtsi"
 
 / {
@@ -54,7 +57,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 12 0>;
+	phy-reset-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index e88b2a6be079..c83ac1600322 100644
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
index 2e44d2aba14e..df705ba48897 100644
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
index c05e7cfd0cbc..d0d273ddd76e 100644
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
index 542ab9e697fb..9205e32e3a6f 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -274,6 +274,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index bd3dfefa5778..07abe704c065 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -202,7 +202,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	phy-handle = <&phy0>;
 	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index ba689fbd0e41..774f04101451 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -138,7 +138,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 2 0>;
+	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 3d958362d874..8cf23bea2f2a 100644
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
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index 732eb66f7657..5434fe664f65 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -119,7 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	phy-supply = <&vgen2_1v2_eth>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index 9647c099acc6..b25284e35047 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -138,7 +138,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 747bc104ad00..c7cd49651409 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -155,7 +155,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii-id";
-	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 1723e89e3acc..a8cae9b30d76 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -218,7 +218,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_novena>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	rxc-skew-ps = <3000>;
 	rxdv-skew-ps = <0>;
 	txc-skew-ps = <3000>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index ecbc6eba6a2c..54f3a9a4a50c 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -119,7 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 7d81100e7d47..13da8623f595 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -323,7 +323,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio7 18 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 18 GPIO_ACTIVE_LOW>;
 	txd0-skew-ps = <0>;
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi b/arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
index 469ef58ce4bc..dbe3552de63b 100644
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
index fcaf92f61f6b..abee1e0801a4 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -272,7 +272,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 27 0>;
+	phy-reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
 	txen-skew-ps = <0>;
 	txc-skew-ps = <3000>;
 	rxdv-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 45adbc8dfdb9..11793d775277 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -179,7 +179,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 39b85aef93e1..41dc9ad56180 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -250,7 +250,7 @@
 		 <&clks IMX6QDL_CLK_ENET_REF>;
 	clock-names = "ipg", "ahb", "ptp", "enet_out";
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	phy-handle = <&etnphy>;
 	phy-supply = <&reg_3v3_etn>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
index ef7fa62b9898..794547ecdc4b 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
@@ -18,17 +18,17 @@
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
-				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0		/* uSDHC1 CD */
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x0b0b1		/* uSDHC3 CD */
 				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x0f0b0		/* WL_REF_ON */
 				MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x0f0b0		/* WL_RST_N */
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x000b0		/* WL_REG_ON */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000	/* WL_HOST_WAKE */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000	/* WL_WAKE */
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
-				MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x80000000	/* BT_ON */
-				MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x80000000	/* BT_WAKE */
-				MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x80000000	/* BT_HOST_WAKE */				
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0		/* WL_HOST_WAKE */
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0		/* WL_WAKE */
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0		/* RGMII_nRST */
+				MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x0b0b1		/* BT_ON */
+				MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x0b0b1		/* BT_WAKE */
+				MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x0b0b1		/* BT_HOST_WAKE */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
index 8d893a78cdf0..159a6579c693 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
@@ -18,17 +18,17 @@
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0		/* GPIO_0_CLKO */
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x80000000	/* uSDHC1 CD */
-				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000	/* uSDHC3 CD */
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0		/* uSDHC1 CD */
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x0b0b1		/* uSDHC3 CD */
 				MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00	0x0f0b0		/* WIFI_ON (reset, active low) */
 				MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x000b0		/* WL_REG_ON (unused) */
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x80000000	/* WL_HOST_WAKE, input */
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0		/* WL_HOST_WAKE, input */
 				MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31	0x0f0b0		/* GPIO5_IO31 (Wifi Power Enable) */
-				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x80000000	/* WL_WAKE (unused) */
-				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x80000000	/* BT_ON */
-				MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30	0x80000000	/* BT_WAKE */
-				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x80000000	/* BT_HOST_WAKE */
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x80000000	/* RGMII_nRST */
+				MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0		/* WL_WAKE (unused) */
+				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x1b0b0		/* BT_ON */
+				MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30	0x1b0b0		/* BT_WAKE */
+				MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20	0x1b0b0		/* BT_HOST_WAKE */
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1b0b0		/* RGMII_nRST */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 4d2b0cfd0cb7..dab1a55f1ec9 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -208,7 +208,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 29 0>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
 			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts b/arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
index d25899b71575..0c380df39ae3 100644
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
index 437e9aad5920..5caf5534ea3d 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -309,7 +309,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy0>;
 	status = "okay";
@@ -344,7 +344,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2 &pinctrl_etnphy1_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy1>;
 	status = "disabled";
-- 
2.8.1
