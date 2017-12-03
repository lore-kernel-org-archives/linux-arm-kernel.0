From: david@lechnology.com (David Lechner)
Date: Sun,  3 Dec 2017 13:29:33 -0600
Subject: [PATCH] ARM: da850: Fix LEGO EV3 battery voltage gpio
Message-ID: <1512329373-17321-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the battery voltage monitoring gpio-hog settings.

When the gpio is low, it turns off the battery voltage to the ADC chip.
However, this needs to be on all of the time so that we can monitor
battery voltage.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index aeb5fb0..9d15982 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -463,7 +463,7 @@
 	batt_volt_en {
 		gpio-hog;
 		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
+		output-high;
 	};
 
 	/* Don't impede Bluetooth clock signal */
-- 
2.7.4
