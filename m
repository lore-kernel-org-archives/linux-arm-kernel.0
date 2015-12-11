From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 11 Dec 2015 14:22:04 +0100
Subject: [PATCH] I.MX6: Fix Ethernet PHY mode on Ventana boards
Message-ID: <m3r3itaznn.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gateworks Ventana boards seem to need "RGMII-ID" (internal delay)
PHY mode, instead of simple "RGMII", for their Marvell 88E1510
transceiver. Otherwise, the Ethernet MAC doesn't work with Marvell PHY
driver (TX doesn't seem to work correctly).

Tested on GW5400 rev. C.

This bug affects ARM Fedora 23.

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
Acked-by: Tim Harvey <tharvey@gateworks.com>
Cc: stable at vger.kernel.org

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 822ffb2..6c168dc 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -154,7 +154,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 7b31fdb..dc0cebf 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -94,7 +94,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1b66328..18cd411 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -154,7 +154,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 7c51839..eea90f3 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -155,7 +155,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 929e0b3..6c11a2a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -145,7 +145,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
