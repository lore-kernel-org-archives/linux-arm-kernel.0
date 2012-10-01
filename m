From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  1 Oct 2012 11:43:44 +0100
Subject: [PATCH 3/7] ARM: ux500: Correct Snowball's external SD/MMC slot's bus
 width
In-Reply-To: <1349088228-8582-1-git-send-email-lee.jones@linaro.org>
References: <1349088228-8582-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349088228-8582-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Snowball's external SD/MMC slot is only capable of 4 bit data
transfer, not 8 bits as previously thought. This is a simple
fixup moving to the correct settings.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 9a37244..6a2b58b 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -123,7 +123,7 @@
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
 			max-frequency = <50000000>;
-			bus-width = <8>;
+			bus-width = <4>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
-- 
1.7.9.5
