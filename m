From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 15 Dec 2017 14:09:54 +0200
Subject: [PATCH] ARM: dts: am43xx-epos-evm: Add phandle for the backlight for
 the panel
Message-ID: <20171215120954.21711-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the backlight phandle the driver can manage the backlight on/off in
sync with the panel enable/disable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a04d79ec212a..fdb1e2bbab9c 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -48,6 +48,8 @@
 		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
 		label = "lcd";
 
+		backlight = <&lcd_bl>;
+
 		panel-timing {
 			clock-frequency = <33000000>;
 			hactive = <800>;
@@ -107,7 +109,7 @@
 			0x03030069>;	/* LEFT */
 	};
 
-	backlight {
+	lcd_bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
