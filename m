From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 18 Jan 2013 15:36:34 +0100
Subject: [PATCH 5/5] ARM: dts: omap4-sdp: Add support for pwm-backlight
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1358519794-13214-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Section to describe the backlight for the LCD panels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 8101a94..c2dee41 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -95,6 +95,17 @@
 		};
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 1 7812500>;
+		brightness-levels = <
+				0 10 20 30 40
+				50 60 70 80 90
+				100 110 120 127
+				>;
+		default-brightness-level = <13>;
+	};
+
 	sound {
 		compatible = "ti,abe-twl6040";
 		ti,model = "SDP4430";
-- 
1.8.1
