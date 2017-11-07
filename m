From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue,  7 Nov 2017 11:32:39 +0100
Subject: [PATCH 1/1] add rgb888 pins to a20 to enable parallel rgb LCD
Message-ID: <1510050759-6110-1-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch gives possibility to set parallel lcd pins for RGB888.
To be used with tcon0 in your <target>.dts

Best regards
Giulio Benetti
Micronova srl

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 228c368..b85a917 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -921,6 +921,14 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd_rgb888_pins: lcd-rgb888 at 0 {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7", 
+					"PD8", "PD9", "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+					"PD16", "PD17", "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+					"PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer at 1c20c00 {
-- 
2.7.4
