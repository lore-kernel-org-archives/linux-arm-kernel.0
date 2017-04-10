From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 10 Apr 2017 13:58:10 -0700
Subject: [PATCH v2] ARM: dts: imx: ventana: fix DTC warnings
In-Reply-To: <1491252168-7934-1-git-send-email-tharvey@gateworks.com>
References: <1491252168-7934-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1491857890-10554-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the sky2 ethernet device node from the pcie controller which was
invalid to begin with.

The original intent was to allow the bootloader to populate the MAC via
dt but this requires the PCI bus topology to be complete in dt as well
and as these boards have an expansion connector that topology is dynamic
and can't be represented here.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - remove eth1 aliases

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 5 -----
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 -----
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 8e84713..687ab91 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -19,7 +19,6 @@
 
 	/* these are used by bootloader for disabling nodes */
 	aliases {
-		ethernet1 = &eth1;
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
@@ -347,10 +346,6 @@
 &pcie {
 	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
 };
 
 &ssi1 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index a208e7e..5bc6ed1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -14,7 +14,6 @@
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
-		ethernet1 = &eth1;
 		led0 = &led0;
 		led1 = &led1;
 		led2 = &led2;
@@ -342,10 +341,6 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
 };
 
 &pwm2 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 968fda9..66fcf838 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -14,7 +14,6 @@
 / {
 	/* these are used by bootloader for disabling nodes */
 	aliases {
-		ethernet1 = &eth1;
 		led0 = &led0;
 		led1 = &led1;
 		led2 = &led2;
@@ -379,10 +378,6 @@
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
-
-	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
-		compatible = "marvell,sky2";
-	};
 };
 
 &pwm1 {
-- 
2.7.4
