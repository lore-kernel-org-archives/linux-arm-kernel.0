From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  5 Sep 2012 14:58:56 +0300
Subject: [PATCH v3 8/8] ARM/dts: omap3-beagle: Enable audio support
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1346846336-27321-9-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed sections to enable audio support on BeagleBoard when booted
with DT blob.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 16bff8b..10d87a2 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -25,6 +25,14 @@
 			gpios = <&twl_gpio 19 0>; /* LEDB */
 		};
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "omap3beagle";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
 };
 
 &i2c1 {
@@ -40,6 +48,12 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3000000>;
 		};
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
-- 
1.7.12
