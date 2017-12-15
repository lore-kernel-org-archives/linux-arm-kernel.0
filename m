From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 15 Dec 2017 14:09:41 +0200
Subject: [PATCH] ARM: dts: am437x-sk-evm: Add phandle for the backlight for
 the panel
Message-ID: <20171215120941.21638-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the backlight phandle the driver can manage the backlight on/off in
sync with the panel enable/disable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 2c6bf0684f50..3fa3b226995d 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -35,7 +35,7 @@
 		clock-frequency = <32768>;
 	};
 
-	backlight {
+	lcd_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -132,6 +132,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins>;
 
+		backlight = <&lcd_bl>;
+
 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 
 		panel-timing {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
