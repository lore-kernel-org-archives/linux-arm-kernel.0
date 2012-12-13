From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 13:22:07 +0000
Subject: [PATCH 5/8] ARM: ux500: Use the correct name when supplying a GPIO
 enable pin
In-Reply-To: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1355404930-5691-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct a typo in the Device Tree source file, where instead of
specifying property 'enable-gpio', which the driver is expecting
we specified 'gpio-enable' instead.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefprev60.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hrefprev60.dts b/arch/arm/boot/dts/hrefprev60.dts
index eec29c4..9194fb6 100644
--- a/arch/arm/boot/dts/hrefprev60.dts
+++ b/arch/arm/boot/dts/hrefprev60.dts
@@ -40,7 +40,7 @@
 
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 0x4>;
-			gpio-enable = <&tc3589x_gpio 17 0x4>;
+			enable-gpio = <&tc3589x_gpio 17 0x4>;
 
 			status = "okay";
 		};
-- 
1.7.9.5
