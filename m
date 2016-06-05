From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun,  5 Jun 2016 13:51:55 +0000
Subject: [PATCH RFT 3/4] ARM: dts: imx28-cfa10049: fix dtc warning
Message-ID: <1465134715-13497-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following dtc warning by removing the unnecessary unit:

Warning (unit_address_vs_reg): Node /onewire at 0 has a unit name,
but no reg property

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index ef944b6..a9c347e 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -426,7 +426,7 @@
 
 	};
 
-	onewire at 0 {
+	onewire {
 		compatible = "w1-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&w1_gpio_pins>;
-- 
1.7.9.5
