From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Mon,  7 May 2018 16:53:09 +0300
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: fix touchscreen bindings
Message-ID: <20180507135309.32580-1-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes errors in RDU1 device tree that cause touch screens not
working.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac04ad08..6464f2560e06 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -523,7 +523,7 @@
 	};
 
 	touchscreen at 20 {
-		compatible = "syna,rmi4_i2c";
+		compatible = "syna,rmi4-i2c";
 		reg = <0x20>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ts>;
@@ -541,8 +541,8 @@
 
 		rmi4-f11 at 11 {
 			reg = <0x11>;
-			touch-inverted-y;
-			touch-swapped-x-y;
+			touchscreen-inverted-y;
+			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
 	};
-- 
2.11.0
