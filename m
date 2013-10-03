From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:30:27 +0200
Subject: [PATCH 05/10] ARM: ux500: correct CD for micro SD on hrev60plus
Message-ID: <1380799827-25890-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This correct the card detect line for the HREF v60 and later
reference designs. This is connected directly to the Nomadik
GPIO block, line 95 at offset 31 on the third instance.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index 1115468..b82ae50 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -40,7 +40,7 @@
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
-			cd-gpios  = <&tc3589x_gpio 3 0x4>;
+			cd-gpios  = <&gpio2 31 0x4>; // 95
 
 			status = "okay";
 		};
-- 
1.8.3.1
