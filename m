From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Jun 2017 12:21:23 +0200
Subject: [PATCH 2/9] ARM: dts/at91: ensure UARTs used for rs485 specify
 rs485-rts-delay
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20170621102130.21024-3-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/serial/rs485.txt the
rs485-rts-delay parameter is required. To prepare making use of
of_get_rs485_mode which is strict here, add this property to all at91
compatible devices that make use of one of the optional properties.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>

 arch/arm/boot/dts/animeo_ip.dts  | 2 ++
 arch/arm/boot/dts/at91-vinco.dts | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 9cc372b9fb9b..26fea9d79f27 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -45,12 +45,14 @@
 		apb {
 			usart0: serial at fffb0000 {
 				pinctrl-0 = <&pinctrl_usart0 &pinctrl_usart0_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
 
 			usart1: serial at fffb4000 {
 				pinctrl-0 = <&pinctrl_usart1 &pinctrl_usart1_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index e0c0b2897a49..7bf8391bc7b3 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -147,6 +147,7 @@
 			usart4: serial at fc010000 {
 				/* LMN */
 				pinctrl-0 = <&pinctrl_usart4 &pinctrl_usart4_rts>;
+				rs485-rts-delay = <0 0>;
 				linux,rs485-enabled-at-boot-time;
 				status = "okay";
 			};
-- 
2.11.0
