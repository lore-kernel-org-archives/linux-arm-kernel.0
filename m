From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 15 Dec 2017 14:09:32 +0200
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add phandle for the backlight for
 the panel
Message-ID: <20171215120932.21572-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the backlight phandle the driver can manage the backlight on/off in
sync with the panel enable/disable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index afb8eb0a0a16..c3b1a3fb5a2e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -55,7 +55,7 @@
 		enable-active-high;
 	};
 
-	backlight {
+	lcd_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -86,6 +86,8 @@
 		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
 		label = "lcd";
 
+		backlight = <&lcd_bl>;
+
 		panel-timing {
 			clock-frequency = <33000000>;
 			hactive = <800>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
