From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  9 May 2018 23:08:08 -0300
Subject: [PATCH 2/3] ARM: dts: imx53-smd: Do not hardcode input codes
In-Reply-To: <1525918089-26242-1-git-send-email-festevam@gmail.com>
References: <1525918089-26242-1-git-send-email-festevam@gmail.com>
Message-ID: <1525918089-26242-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Instead of hardcoding the input codes we can use the symbol name for
better readability.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-smd.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index fd03012..705af5e 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -11,6 +11,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "imx53.dtsi"
 
 / {
@@ -27,13 +28,13 @@
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio2 14 0>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
+			linux,code = <KEY_VOLUMEUP>;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio2 15 0>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
+			linux,code = <KEY_VOLUMEDOWN>;
 		};
 	};
 };
-- 
2.7.4
