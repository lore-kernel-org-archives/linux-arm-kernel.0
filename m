From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:30:17 +0200
Subject: [PATCH 04/10] ARM: ux500: fix proximity sensor button
Message-ID: <1380799817-25852-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proximity sensor is connected to pin AH12 on newer HREFs,
that corresponds to pin offset 25 on gpio5, not gpio6.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dts b/arch/arm/boot/dts/ste-hrefv60plus.dts
index bb3cfc7..1115468 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dts
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dts
@@ -20,7 +20,7 @@
 
 	gpio_keys {
 		button at 1 {
-			gpios = <&gpio6 25 0x4>;
+			gpios = <&gpio5 25 0x4>;
 		};
 	};
 
-- 
1.8.3.1
