From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  5 Jun 2015 09:42:25 +0200
Subject: [PATCH] ARM: nomadik: set proper compatible for accelerometer
Message-ID: <1433490145-2936-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adjust device tree entry to the proper registered compatible
string for LIS3LV02DL.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC people, please apply this directly for -next on the
DT branch. It makes the accelerometer work on the Nomadik.
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index f182f6538e90..9a5f2ba139b7 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -722,8 +722,9 @@
 			   reg = <0x1a>;
 		};
 		lis3lv02dl at 1d {
-			   compatible = "st,lis3lv02dl";
-			   reg = <0x1d>;
+			/* Accelerometer */
+			compatible = "st,lis3lv02dl-accel";
+			reg = <0x1d>;
 		};
 	};
 
-- 
2.4.2
