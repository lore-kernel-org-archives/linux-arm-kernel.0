From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 10 Feb 2015 09:55:35 +0800
Subject: [PATCH v2 2/2] ARM: at91: dt: at91sam9n12ek: enable udp
In-Reply-To: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
References: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1423533335-25135-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable usb device port on at91sam9n12ek board.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

Changes in v2:
  - Add pinctrl for usb1 vbus sense.

 arch/arm/boot/dts/at91sam9n12ek.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 9575c0d..6123109 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -108,6 +108,13 @@
 							<AT91_PIOB 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;
 					};
 				};
+
+				usb1 {
+					pinctrl_usb1_vbus_sense: usb1_vbus_sense {
+						atmel,pins =
+							<AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;	/* PB16 gpio usb vbus sense, no pull up and deglitch */
+					};
+				};
 			};
 
 			spi0: spi at f0000000 {
@@ -120,6 +127,13 @@
 				};
 			};
 
+			usb1: gadget at f803c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usb1_vbus_sense>;
+				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
+				status = "okay";
+			};
+
 			watchdog at fffffe40 {
 				status = "okay";
 			};
-- 
2.3.0.rc0
