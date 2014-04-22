From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Apr 2014 00:05:41 +0200
Subject: [PATCH] ARM: at91: add pull-up to i2c[02] on SAMA5D3 Xplained
Message-ID: <1398204341-13653-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there are no pull-up resistors on the board itself it can be useful to
use the SoC pad pull-up to be able to easily connect usual i2c devices.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index ce1375595e5f..ff8a159bb600 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -43,6 +43,7 @@
 			};
 
 			i2c0: i2c at f0014000 {
+				pinctrl-0 = <&pinctrl_i2c0_pu>;
 				status = "okay";
 			};
 
@@ -102,6 +103,7 @@
 
 			i2c2: i2c at f801c000 {
 				dmas = <0>, <0>;	/* Do not use DMA for i2c2 */
+				pinctrl-0 = <&pinctrl_i2c2_pu>;
 				status = "okay";
 			};
 
@@ -116,6 +118,18 @@
 
 			pinctrl at fffff200 {
 				board {
+					pinctrl_i2c0_pu: i2c0_pu {
+						atmel,pins =
+							<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
+							<AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+					};
+
+					pinctrl_i2c2_pu: i2c2_pu {
+						atmel,pins =
+							<AT91_PIOA 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>,
+							<AT91_PIOA 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
+					};
+
 					pinctrl_mmc0_cd: mmc0_cd {
 						atmel,pins =
 							<AT91_PIOE 0 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;
-- 
1.8.2.2
