From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 14:40:00 +0200
Subject: [RFC PATCH 2/3] ARM: dts: OX810: Update with dt-bindings includes
In-Reply-To: <20161017124001.23820-1-narmstrong@baylibre.com>
References: <20161017124001.23820-1-narmstrong@baylibre.com>
Message-ID: <20161017124001.23820-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OX810SE dt-bindings includes files for clocks and resets, replace
resets numbers by human readable defines.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index ce13705..46aa6db 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -7,6 +7,8 @@
  */
 
 /include/ "skeleton.dtsi"
+#include <dt-bindings/clock/oxsemi,ox810se.h>
+#include <dt-bindings/reset/oxsemi,ox810se.h>
 
 / {
 	compatible = "oxsemi,ox810se";
@@ -242,7 +244,7 @@
 			       current-speed = <115200>;
 			       no-loopback-test;
 			       status = "disabled";
-			       resets = <&reset 17>;
+			       resets = <&reset RESET_UART1>;
 			};
 
 			uart1: serial at 300000 {
@@ -256,7 +258,7 @@
 			       current-speed = <115200>;
 			       no-loopback-test;
 			       status = "disabled";
-			       resets = <&reset 18>;
+			       resets = <&reset RESET_UART2>;
 			};
 
 			uart2: serial at 900000 {
@@ -270,7 +272,7 @@
 			       current-speed = <115200>;
 			       no-loopback-test;
 			       status = "disabled";
-			       resets = <&reset 22>;
+			       resets = <&reset RESET_UART3>;
 			};
 
 			uart3: serial at a00000 {
@@ -284,7 +286,7 @@
 			       current-speed = <115200>;
 			       no-loopback-test;
 			       status = "disabled";
-			       resets = <&reset 23>;
+			       resets = <&reset RESET_UART4>;
 			};
 		};
 
-- 
2.7.0
