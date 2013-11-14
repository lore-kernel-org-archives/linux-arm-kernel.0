From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 10:07:30 -0800
Subject: [PATCH] ARM: dts: bcm28155-ap: Fix Card Detection GPIO
Message-ID: <1384452450-26308-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board schematic states that the "SD_CARD_DET_N gets pulled to GND
when card is inserted" so the polarity has been updated to active low.

Polarity is now specified with a GPIO define instead of a magic number.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 arch/arm/boot/dts/bcm28155-ap.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..27dd110 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -13,6 +13,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "bcm11351.dtsi"
 
 / {
@@ -40,7 +42,7 @@
 
 	sdio4: sdio at 3f1b0000 {
 		max-frequency = <48000000>;
-		cd-gpios = <&gpio 14 0>;
+		cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
 		status = "okay";
 	};
 };
-- 
1.8.0.1
