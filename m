From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:10 +0900
Subject: [PATCH 04/19] ARM: shmobile: kzm9d: sort dts file by address
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <b97950cf04b32adf0f7521397c5fefa17208e71d.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 62 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 50ccd15..a1794cb 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -27,37 +27,6 @@
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
-	reg_1p8v: regulator at 0 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	reg_3p3v: regulator at 1 {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	lan9220 at 20000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x20000000 0x10000>;
-		phy-mode = "mii";
-		interrupt-parent = <&gpio0>;
-		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
-		reg-io-width = <4>;
-		smsc,irq-active-high;
-		smsc,irq-push-pull;
-		vddvario-supply = <&reg_1p8v>;
-		vdd33a-supply = <&reg_3p3v>;
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
@@ -92,4 +61,35 @@
 			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	reg_1p8v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3p3v: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	lan9220 at 20000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x20000000 0x10000>;
+		phy-mode = "mii";
+		interrupt-parent = <&gpio0>;
+		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
 };
-- 
2.1.1
