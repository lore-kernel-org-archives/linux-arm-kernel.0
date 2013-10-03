From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:30:03 +0200
Subject: [PATCH 03/10] ARM: ux500: correct I2C address of ambient light sensor
Message-ID: <1380799803-25812-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ambient light sensor is places at address 0x29 nothing else.
This patch makes the ambient light sensor probe again.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index d675326..a561bc3 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -103,7 +103,7 @@
 			};
 			bh1780 at 29 {
 				compatible = "rohm,bh1780gli";
-				reg = <0x33>;
+				reg = <0x29>;
 			};
 		};
 
-- 
1.8.3.1
