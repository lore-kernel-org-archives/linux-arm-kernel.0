From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:14 +0100
Subject: [PATCH v3 10/15] at91: dt: at91sam9261ek: Added support for the LCD
 display
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-11-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 5555e9f5..287b283 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -32,6 +32,37 @@
 	};
 
 	ahb {
+		fb0: fb at 0x00600000 {
+			display = <&display0>;
+			atmel,power-control-gpio = <&pioA 12 GPIO_ACTIVE_LOW>;
+			status = "okay";
+
+			display0: display {
+				bits-per-pixel = <16>;
+				atmel,lcdcon-backlight;
+				atmel,dmacon = <0x1>;
+				atmel,lcdcon2 = <0x80008002>;
+				atmel,guard-time = <1>;
+				atmel,lcd-wiring-mode = "BRG";
+
+				display-timings {
+					native-mode = <&timing0>;
+					timing0: timing0 {
+						clock-frequency = <4965000>;
+						hactive = <240>;
+						vactive = <320>;
+						hback-porch = <1>;
+						hfront-porch = <33>;
+						vback-porch = <1>;
+						vfront-porch = <0>;
+						hsync-len = <5>;
+						vsync-len = <1>;
+						hsync-active = <1>;
+						vsync-active = <1>;
+					};
+				};
+			};
+		};
 
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
-- 
1.8.5.2
