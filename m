From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 10 Jul 2016 12:07:45 +0200
Subject: [PATCH 5/6] ARM: dts: imx: fix polarity of fec reset gpios
In-Reply-To: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <1468145266-7567-6-git-send-email-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fec driver ignores the polarity flags of the references in
phy-reset-gpios and assumes them to be active low unlesss there is a
property phy-reset-active-high.

So fix all device trees that specify (maybe implicitly) an active high
gpio without the phy-reset-active-high property.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts          | 5 ++++-
 arch/arm/boot/dts/imx25-pdk.dts                | 2 +-
 arch/arm/boot/dts/imx50-evk.dts                | 5 ++++-
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
 23 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index c622c342efa0..901ef21a38d8 100644
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
index 643d083951ef..cf41b726e2de 100644
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
index 04cefa7c950f..29706cf4b5ef 100644
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
index aa5861610834..2ed675a8e4bf 100644
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
index fa6438141747..2099861d6013 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -189,7 +189,7 @@
 };
 
 &fec {
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index baebcd3a0515..da481610a8b4 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -342,7 +342,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index 105b5e0972ff..5f8ecbe1b65b 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -272,6 +272,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 13deaa664eb8..f4a47aec9ecb 100644
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
index 1ad10374b3c5..fbdd38f0fca0 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -136,7 +136,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 2 0>;
+	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 34a8927b6206..d11fd9607f01 100644
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
index 63bf517ad568..5571e07cb276 100644
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
index bb7067e9e32e..706422ac46f9 100644
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
index f7e6803992ee..534494f82745 100644
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
index 631fa6eacc79..d073796a9d0b 100644
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
index dcfdb2c24e62..329b36c44c54 100644
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
index 53e6df5a5f6a..dde6337102f1 100644
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
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index cc845026cd60..3590080a4f44 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -205,7 +205,7 @@
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
