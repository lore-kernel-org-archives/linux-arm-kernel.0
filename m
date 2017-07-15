From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 15 Jul 2017 10:06:25 -0300
Subject: [PATCH] ARM: dts: imx6qdl-gw5xxx: Remove the 'uart-has-rtscts'
 property
Message-ID: <1500123985-23754-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'uart-has-rtscts' property should be used when the board exposes the
native RTS and CTS UART pins.

On the imx6qdl-gw5xxx boards such pins are not used, so remove the
'uart-has-rtscts' property to make the hardware description correct.

Documentation/devicetree/bindings/serial/serial.txt states that
'uart-has-rtscts' and 'rts-gpios' properties are mutually exclusive.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 91991d6..115d706 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -377,7 +377,6 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
 	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 5bc6ed1..24be796 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -368,7 +368,6 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
 	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 66fcf838..4594b22 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -416,7 +416,6 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
 	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
-- 
2.7.4
