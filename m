From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:36:32 +0100
Subject: [PATCH 3/5] ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519794-13214-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have proper driver stack to handle the pmu_stat LED which is connected
PWMB of twl4030.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 3705a81..1c85e0f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -20,10 +20,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pmu_stat {
-			label = "beagleboard::pmu_stat";
-			gpios = <&twl_gpio 19 0>; /* LEDB */
-		};
 
 		heartbeat {
 			label = "beagleboard::usr0";
@@ -38,6 +34,16 @@
 		};
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+
+		pmu_stat {
+			label = "beagleboard::pmu_stat";
+			pwms = <&twl_pwmled 1 7812500>;
+			max-brightness = <127>;
+		};
+	};
+
 	sound {
 		compatible = "ti,omap-twl4030";
 		ti,model = "omap3beagle";
-- 
1.8.1
