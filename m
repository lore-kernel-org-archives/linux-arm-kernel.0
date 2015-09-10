From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Sep 2015 10:09:51 +0200
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <1441872592-388-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1441872592-388-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1441872592-388-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commits:

281ec367bff4 (i2c: efm32: correct namespacing of location property)
d36f47fa8419 (serial: efm32: correct namespacing of location property)
10ed7e9847b6 (spi: efm32: correct namespacing of location property)

(contained in 3.17-rc1) all drivers support the correctly
namespaced location property. So use the better names now.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/efm32gg-dk3750.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index b4031fa4a567..504cf45d3cb8 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -26,7 +26,7 @@
 		};
 
 		i2c at 4000a000 {
-			efm32,location = <3>;
+			energymicro,location = <3>;
 			status = "ok";
 
 			temp at 48 {
@@ -43,7 +43,7 @@
 
 		spi0: spi at 4000c000 { /* USART0 */
 			cs-gpios = <&gpio 68 1>; // E4
-			location = <1>;
+			energymicro,location = <1>;
 			status = "ok";
 
 			microsd at 0 {
@@ -57,7 +57,7 @@
 
 		spi1: spi at 4000c400 { /* USART1 */
 			cs-gpios = <&gpio 51 1>; // D3
-			location = <1>;
+			energymicro,location = <1>;
 			status = "ok";
 
 			ks8851 at 0 {
@@ -70,7 +70,7 @@
 		};
 
 		uart4: uart at 4000e400 { /* UART1 */
-			location = <2>;
+			energymicro,location = <2>;
 			status = "ok";
 		};
 
-- 
2.5.0
