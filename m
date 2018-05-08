From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 8 May 2018 13:04:33 +0300
Subject: [PATCH] ARM: dts: am335x-evmsk: Add phandle for the backlight for the
 panel
Message-ID: <20180508100433.1051-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the backlight phandle the driver can manage the backlight on/off in
sync with the panel enable/disable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index d0d6bacfafc2..0c096a795e37 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -137,7 +137,7 @@
 		};
 	};
 
-	backlight {
+	lcd_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap2 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 58 61 66 75 90 125 170 255>;
@@ -172,6 +172,7 @@
 		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&lcd_pins_default>;
 		pinctrl-1 = <&lcd_pins_sleep>;
+		backlight = <&lcd_bl>;
 		status = "okay";
 		panel-info {
 			ac-bias		= <255>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
