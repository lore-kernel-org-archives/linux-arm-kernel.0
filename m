From: seanpaul@chromium.org (Sean Paul)
Date: Tue,  1 Oct 2013 19:41:00 -0400
Subject: [PATCH 5/5] ARM: dts: Add ptn3460 to exynos5250-snow
In-Reply-To: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
Message-ID: <1380670860-17621-6-git-send-email-seanpaul@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a node for the ptn3460 DP-LVDS chip in the
exynos5250-snow board dts file.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 780511a..122fc1f 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -33,6 +33,13 @@
 		sd3_bus4: sd3-bus-width4 {
 			samsung,pin-drv = <0>;
 		};
+
+		ptn3460_gpios: ptn3460-gpios {
+			samsung,pins = "gpy2-5", "gpx1-5";
+			samsung,pin-function = <1>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
 	};
 
 	gpio-keys {
@@ -190,6 +197,18 @@
 		samsung,vbus-gpio = <&gpx1 1 0>;
 	};
 
+	i2c at 12CD0000 {
+		ptn3460-bridge at 20 {
+			compatible = "nxp,ptn3460";
+			reg = <0x20>;
+			powerdown-gpio = <&gpy2 5 0>;
+			reset-gpio = <&gpx1 5 0>;
+			edid-emulation = <5>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ptn3460_gpios>;
+		};
+	};
+
 	dp-controller {
 		samsung,color-space = <0>;
 		samsung,dynamic-range = <0>;
-- 
1.8.4
