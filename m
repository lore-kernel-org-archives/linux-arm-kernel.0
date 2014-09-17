From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Sep 2014 09:48:15 +0900
Subject: [PATCH v2 4/5] ARM: shmobile: kzm9d: sort dts file by address
In-Reply-To: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
References: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1410914896-14395-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[horms+renesas at verge.net.au: updated for removal of regulator base addresses]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2 [Simon Horman]
* Rebase
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 62 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index f27fcf0..922da27 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -27,37 +27,6 @@
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
-	reg_1p8v: regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	reg_3p3v: regulator {
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
+	reg_1p8v: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3p3v: regulator {
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
2.0.1
