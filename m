From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 17:39:18 -0300
Subject: [PATCH 3/6] ARM: dts: imx23-evk: Move regulators outside simple-bus
In-Reply-To: <1532119161-16597-1-git-send-email-festevam@gmail.com>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
Message-ID: <1532119161-16597-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is recommended to place regulators outside simple-bus, so move them
accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx23-evk.dts | 42 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 9fb4772..494095d 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -13,6 +13,23 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
+	reg_vddio_sd0: regulator-vddio-sd0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 29 0>;
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 18 0>;
+		enable-active-high;
+	};
+
 	apb at 80000000 {
 		apbh at 80000000 {
 			gpmi-nand at 8000c000 {
@@ -118,31 +135,6 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_vddio_sd0: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vddio-sd0";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 29 0>;
-		};
-
-		reg_lcd_3v3: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "lcd-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 18 0>;
-			enable-active-high;
-		};
-	};
-
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm 2 5000000>;
-- 
2.7.4
