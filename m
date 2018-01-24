From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:31:48 +0100
Subject: [PATCH] ARM: dts: fix the at24 compatible string in imx6q-h100
Message-ID: <20180124213148.4435-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 'at24' as fallback is now deprecated - use the full
'atmel,<model>' string.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/imx6q-h100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 8a2ea6c58902..cca1587bf7da 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -161,7 +161,7 @@
 	status = "okay";
 
 	eeprom: 24c02 at 51 {
-		compatible = "microchip,24c02", "at24";
+		compatible = "microchip,24c02", "atmel,24c02";
 		reg = <0x51>;
 	};
 
-- 
2.16.1
