From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  5 Jun 2016 13:52:27 +0000
Subject: [PATCH RFT 4/4] ARM: dts: imx28-tx28: fix dtc warning
Message-ID: <1465134747-13536-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following dtc warning by removing the unnecessary unit:

Warning (unit_address_vs_reg): Node /matrix-keypad at 0 has a unit name,
but no reg property

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28-tx28.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index fd20e99..0ebbc83 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -173,7 +173,7 @@
 		default-brightness-level = <50>;
 	};
 
-	matrix_keypad: matrix-keypad at 0 {
+	matrix_keypad: matrix-keypad {
 		compatible = "gpio-matrix-keypad";
 		col-gpios = <
 			&gpio5 0 GPIO_ACTIVE_HIGH
-- 
1.7.9.5
