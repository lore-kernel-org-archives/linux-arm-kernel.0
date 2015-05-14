From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 19:53:48 +0900
Subject: [PATCH v3 3/8] ARM: dts: Remove duplicated I2C7 nodes in
 exynos5250-snow
In-Reply-To: <1431600833-3361-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431600833-3361-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431600833-3361-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c_7 node (i2c at 12CD0000) with LVDS bridge child node was put in
Exynos5250 Snow DTS file twice. Move the LVDS bridge to proper existing
i2c_7 node.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 46 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 1eca97ee4bd6..b7f4122df456 100644
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
2.1.4
