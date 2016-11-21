From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 16:41:55 +0100
Subject: [PATCH] ARM: dts: da850-lcdk: fix mmc card detect polarity
Message-ID: <20161121154155.16985-1-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The polarity of the card detect pin is inverted.

Change it to reflect the right polarity for the board
which is ACTIVE_LOW.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..07bb40f4 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -122,7 +122,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	cd-gpios = <&gpio 64 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.9.3
