From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 12 Apr 2015 21:24:50 +0900
Subject: [PATCH 3/7] ARM: dts: Remove duplicated I2C 7 nodes in Snow
In-Reply-To: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1428841494-20769-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1428841494-20769-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c_7 node (i2c at 12CD0000) with LVDS bridge child node was put in
Exynos5250 Snow DTS file twice.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 46 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 2657e842e5a5..7ecdad0517e7 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -177,30 +177,6 @@
 		};
 	};
 
-	i2c at 12CD0000 {
-		ptn3460: lvds-bridge at 20 {
-			compatible = "nxp,ptn3460";
-			reg = <0x20>;
-			powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
-			reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
-			edid-emulation = <5>;
-
-			ports {
-				port at 0 {
-					bridge_out: endpoint {
-						remote-endpoint = <&panel_in>;
-					};
-				};
-
-				port at 1 {
-					bridge_in: endpoint {
-						remote-endpoint = <&dp_out>;
-					};
-				};
-			};
-		};
-	};
-
 	sound {
 		compatible = "google,snow-audio-max98095";
 
@@ -507,6 +483,28 @@
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <66000>;
 
+	ptn3460: lvds-bridge at 20 {
+		compatible = "nxp,ptn3460";
+		reg = <0x20>;
+		powerdown-gpios = <&gpy2 5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpx1 5 GPIO_ACTIVE_HIGH>;
+		edid-emulation = <5>;
+
+		ports {
+			port at 0 {
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+
+			port at 1 {
+				bridge_in: endpoint {
+					remote-endpoint = <&dp_out>;
+				};
+			};
+		};
+	};
+
 	max98095: codec at 11 {
 		compatible = "maxim,max98095";
 		reg = <0x11>;
-- 
2.1.0
