From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:29:09 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for at91sam9263ek
Message-ID: <20180124212909.4224-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/at91sam9263ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index e9a7c70830a8..727096f24f7c 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -250,7 +250,7 @@
 		status = "okay";
 
 		24c512 at 50 {
-			compatible = "24c512";
+			compatible = "atmel,24c512";
 			reg = <0x50>;
 			pagesize = <128>;
 		};
-- 
2.16.1
