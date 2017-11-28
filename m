From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 28 Nov 2017 15:02:35 +0000
Subject: [PATCH v2 08/16] ARM: dts: imx6qdl-sr-som: add 3.3V vcc regulator
In-Reply-To: <20171128150045.GV31757@n2100.armlinux.org.uk>
References: <20171128150045.GV31757@n2100.armlinux.org.uk>
Message-ID: <E1eJhP9-0006Nr-TC@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 3.3V regulator for devices connected to the vcc_3v3 supply
signal on the microsom.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
index 449e241badfe..4ccb7afc4b35 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
@@ -40,6 +40,16 @@
  */
 #include <dt-bindings/gpio/gpio.h>
 
+/ {
+	vcc_3v3: regulator-vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-name = "vcc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
-- 
2.7.4
