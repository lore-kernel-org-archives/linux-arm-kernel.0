From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 14 Mar 2014 16:53:36 +0100
Subject: [PATCH 1/2] ARM: efm32: fix unit address part in USART2 device nodes'
 names
In-Reply-To: <1394812417-22391-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1394812417-22391-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1394812417-22391-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While removing the 0x prefixes in the unit addresses in reply to a review
comment, I must somehow have messed up these two. Uups.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/efm32gg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
index a342ab0e6e4f..106d505c5d3d 100644
--- a/arch/arm/boot/dts/efm32gg.dtsi
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -84,7 +84,7 @@
 			status = "disabled";
 		};
 
-		spi2: spi at 40x4000c800 { /* USART2 */
+		spi2: spi at 4000c800 { /* USART2 */
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "efm32,spi";
@@ -110,7 +110,7 @@
 			status = "disabled";
 		};
 
-		uart2: uart at 40x4000c800 { /* USART2 */
+		uart2: uart at 4000c800 { /* USART2 */
 			compatible = "efm32,uart";
 			reg = <0x4000c800 0x400>;
 			interrupts = <18 19>;
-- 
1.9.0
