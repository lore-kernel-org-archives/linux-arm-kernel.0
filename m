From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Nov 2018 15:53:59 -0200
Subject: [PATCH v2] ARM: dts: imx51-zii-rdu1: Remove EEPROM node
Message-ID: <1541872439-31531-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EEPROM under I2C2 was put by mistake in the dts.

Remove it as it is not really present on the real hardware.

Fixes: ceef0396f367 ("ARM: dts: imx: add ZII RDU1 board")
Reported-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- None. Only added Chris on Cc

 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 3ca4f9b..28e9dca 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -493,12 +493,6 @@
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
-	eeprom at 50 {
-		compatible = "atmel,24c04";
-		pagesize = <16>;
-		reg = <0x50>;
-	};
-
 	hpa1: amp at 60 {
 		compatible = "ti,tpa6130a2";
 		reg = <0x60>;
-- 
2.7.4
