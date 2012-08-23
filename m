From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 23 Aug 2012 12:29:13 +0300
Subject: [PATCH 6/6] ARM/dts: omap3-beagle: Enable audio support
In-Reply-To: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1345714153-13094-7-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed sections to enable audio support on BeagleBoard when booted
with DT blob.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index cdcb98c..28cf180 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -17,6 +17,14 @@
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
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
@@ -32,6 +40,12 @@
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
1.7.8.6
