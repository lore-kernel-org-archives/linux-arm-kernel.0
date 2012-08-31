From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 31 Aug 2012 11:24:56 +0200
Subject: [PATCH 8/8] ARM: dts: add twi nodes for atmel boards
In-Reply-To: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1346405096-18660-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Use the atmel twi instead of gpio for i2c stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         | 20 ++++++++++----------
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 28 ++++++++++++++--------------
 arch/arm/boot/dts/at91sam9g25ek.dts         | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |  8 ++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |  8 ++++++++
 5 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..772ab75 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,16 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			i2c0: i2c at fff88000 {
+				status = "okay";
+
+				24c512 at 50 {
+					compatible = "24c512";
+					reg = <0x50>;
+					pagesize = <128>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -143,14 +153,4 @@
 			gpio-key,wakeup;
 		};
 	};
-
-	i2c at 0 {
-		status = "okay";
-
-		24c512 at 50 {
-			compatible = "24c512";
-			reg = <0x50>;
-			pagesize = <128>;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..712106b 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,20 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			i2c0: i2c at fffac000 {
+				status = "okay";
+
+				24c512 at 50 {
+					compatible = "24c512";
+					reg = <0x50>;
+				};
+
+				wm8731 at 1b {
+					compatible = "wm8731";
+					reg = <0x1b>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
@@ -106,20 +120,6 @@
 		};
 	};
 
-	i2c at 0 {
-		status = "okay";
-
-		24c512 at 50 {
-			compatible = "24c512";
-			reg = <0x50>;
-		};
-
-		wm8731 at 1b {
-			compatible = "wm8731";
-			reg = <0x1b>;
-		};
-	};
-
 	gpio_keys {
 		compatible = "gpio-keys";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7829a4d..3b0adbc 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,18 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			i2c0: i2c at f8010000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at f8014000 {
+				status = "okay";
+			};
+
+			i2c2: i2c at f8018000 {
+				status = "okay";
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..15e1dd4 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,14 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			i2c0: i2c at fff84000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at fff88000 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index f4e43e3..912b2c2 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -37,6 +37,14 @@
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			i2c0: i2c at f8010000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at f8014000 {
+				status = "okay";
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.11.3
