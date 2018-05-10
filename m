From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 May 2018 23:08:07 -0300
Subject: [PATCH 1/3] ARM: dts: imx53-ard: Do not hardcode input codes
Message-ID: <1525918089-26242-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Instead of hardcoding the input codes we can use the symbol name for
better readability.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-ard.dts | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 80fc007..117bd00 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -11,6 +11,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "imx53.dtsi"
 
 / {
@@ -68,34 +69,34 @@
 		home {
 			label = "Home";
 			gpios = <&gpio5 10 0>;
-			linux,code = <102>; /* KEY_HOME */
+			linux,code = <KEY_HOME>;
 			wakeup-source;
 		};
 
 		back {
 			label = "Back";
 			gpios = <&gpio5 11 0>;
-			linux,code = <158>; /* KEY_BACK */
+			linux,code = <KEY_BACK>;
 			wakeup-source;
 		};
 
 		program {
 			label = "Program";
 			gpios = <&gpio5 12 0>;
-			linux,code = <362>; /* KEY_PROGRAM */
+			linux,code = <KEY_PROGRAM >;
 			wakeup-source;
 		};
 
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio5 13 0>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio4 0 0>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
 };
-- 
2.7.4
