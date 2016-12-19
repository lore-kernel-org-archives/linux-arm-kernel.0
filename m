From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 19 Dec 2016 10:53:54 +0100
Subject: [PATCH] ARM: dts: da850-lcdk: add gpio-keys
Message-ID: <1482141234-11546-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a gpio-keys node for two user buttons present on the board.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 397c77a..628f4de 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "da850.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "DA850/AM1808/OMAP-L138 LCDK";
@@ -90,6 +91,23 @@
 			};
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		user1 {
+			label = "GPIO Key USER1";
+			linux,code = <BTN_0>;
+			gpios = <&gpio 36 GPIO_ACTIVE_LOW>;
+		};
+
+		user2 {
+			label = "GPIO Key USER2";
+			linux,code = <BTN_1>;
+			gpios = <&gpio 37 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &pmx_core {
-- 
2.9.3
