From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:23:46 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for sama5d34ek
Message-ID: <20180124212346.3823-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/sama5d34ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index c8b8449fdc3e..15d5c46013a4 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -38,7 +38,7 @@
 				status = "okay";
 
 				24c256 at 50 {
-					compatible = "24c256";
+					compatible = "atmel,24c256";
 					reg = <0x50>;
 					pagesize = <64>;
 				};
-- 
2.16.1
