From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:36:33 +0100
Subject: [PATCH 4/5] ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and
 charging LED)
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519794-13214-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sections to describe the pwm-leds in the system.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 43e5258..8101a94 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -80,6 +80,21 @@
 		};
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+		kpad {
+			label = "omap4::keypad";
+			pwms = <&twl_pwm 0 7812500>;
+			max-brightness = <127>;
+		};
+
+		charging {
+			label = "omap4:green:chrg";
+			pwms = <&twl_pwmled 0 7812500>;
+			max-brightness = <255>;
+		};
+	};
+
 	sound {
 		compatible = "ti,abe-twl6040";
 		ti,model = "SDP4430";
-- 
1.8.1
