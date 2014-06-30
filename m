From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 30 Jun 2014 17:41:28 +0200
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <20140630154030.GJ14781@pengutronix.de>
References: <20140630154030.GJ14781@pengutronix.de>
Message-ID: <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that both spi and serial driver support these (commits f2bb31057a42
(spi: efm32: properly namespace location property) and
74be65a3cff5 (serial: efm32: properly namespace location property)) use
the better names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/efm32gg-dk3750.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index b4031fa4a567..d5dd2a2a7970 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -43,7 +43,7 @@
 
 		spi0: spi at 4000c000 { /* USART0 */
 			cs-gpios = <&gpio 68 1>; // E4
-			location = <1>;
+			efm32,location = <1>;
 			status = "ok";
 
 			microsd at 0 {
@@ -57,7 +57,7 @@
 
 		spi1: spi at 4000c400 { /* USART1 */
 			cs-gpios = <&gpio 51 1>; // D3
-			location = <1>;
+			efm32,location = <1>;
 			status = "ok";
 
 			ks8851 at 0 {
@@ -70,7 +70,7 @@
 		};
 
 		uart4: uart at 4000e400 { /* UART1 */
-			location = <2>;
+			efm32,location = <2>;
 			status = "ok";
 		};
 
-- 
2.0.0
