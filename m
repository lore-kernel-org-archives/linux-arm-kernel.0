From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:30:30 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for
 qcom-apq8064-cm-qs600
Message-ID: <20180124213030.4316-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index b818ebce0978..209eb21cea00 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -133,7 +133,7 @@
 				clock-frequency = <200000>;
 
 				eeprom at 50 {
-					compatible = "24c02";
+					compatible = "atmel,24c02";
 					reg = <0x50>;
 					pagesize = <32>;
 				};
-- 
2.16.1
