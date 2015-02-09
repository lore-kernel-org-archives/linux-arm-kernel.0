From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 9 Feb 2015 17:40:20 +0800
Subject: [PATCH] ARM: at91: dts: sama5d4ek: add leds in DT node
Message-ID: <1423474820-19118-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the leds DT node in the dts file.
In the leds, d10 is set as heartbeat led.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/at91-sama5d4ek.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 9198b71..0c418be 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -257,4 +257,26 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		d8 {
+			label = "d8";
+			/* PE28, conflicts with usart4 rts pin */
+			gpios = <&pioE 28 GPIO_ACTIVE_LOW>;
+		};
+
+		d9 {
+			label = "d9";
+			gpios = <&pioE 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		d10 {
+			label = "d10";
+			gpios = <&pioE 8 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
-- 
1.9.1
