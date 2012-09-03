From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Mon, 3 Sep 2012 12:20:02 +0200
Subject: [PATCH v2 8/8] ARM: dts: add twi nodes for atmel boards
In-Reply-To: <1346667367-7969-1-git-send-email-ludovic.desroches@atmel.com>
References: <1346667367-7969-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1346667602-8140-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Still use i2c-gpio on boards which have a SoC with a TWI IP which
doesn't have clock stretching in transmission mode.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts    | 12 ++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |  8 ++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts    |  8 ++++++++
 3 files changed, 28 insertions(+)

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
