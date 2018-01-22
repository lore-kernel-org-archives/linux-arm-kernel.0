From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Mon, 22 Jan 2018 13:55:05 +0100
Subject: [PATCH] ARM: dts: da850-lego-ev3: use a correct fallback for at24
 compatible
Message-ID: <20180122125505.16806-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now require all at24 users to use the "atmel,<model>" fallback in
device tree for different manufacturers.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 81942ae83e1f..ce4b10988650 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -293,7 +293,7 @@
 	 * EEPROM contains the first stage bootloader, HW ID and Bluetooth MAC.
 	 */
 	eeprom at 50 {
-		compatible = "microchip,24c128";
+		compatible = "microchip,24c128", "atmel,24c128";
 		pagesize = <64>;
 		read-only;
 		reg = <0x50>;
-- 
2.15.1
