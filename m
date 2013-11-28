From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 28 Nov 2013 11:28:44 +0200
Subject: [PATCH] ARM: DTS: omap4-sdp: Add regulator for LCD backlight
 (pwm-backlight)
Message-ID: <1385630924-16392-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since in DT booted kernel dummy regulators are no longer supported we need
to provide valid phandle for the regulator needed by the backlight.
On the board VBAT is used to power the LCD backlight(s).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

This patch is needed for 3.13 to get the LCD backlight to work again.

Regards,
Peter

 arch/arm/boot/dts/omap4-sdp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5fc3f43..6f86db2 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -104,6 +104,7 @@
 				100 110 120 127
 				>;
 		default-brightness-level = <13>;
+		power-supply = <&vbat>;
 	};
 
 	sound {
-- 
1.8.4.2
