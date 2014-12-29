From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:57 +0900
Subject: [PATCH 26/30] ARM: shmobile: ape6evm: Add keypad to the device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <2670ee894f477c9dfe9da7cf774c167b2ba06594.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index b939a37..6b7bc1f 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -11,6 +11,7 @@
 /dts-v1/;
 #include "r8a73a4.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "APE6EVM";
@@ -110,6 +111,46 @@
 			label = "BBRESETOUT";
 		};
 	};
+
+	keyboard {
+		compatible = "gpio-keys";
+
+		zero-key {
+			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_0>;
+			label = "S16";
+		};
+
+		menu-key {
+			gpios = <&pfc 325 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+			label = "S17";
+		};
+
+		home-key {
+			gpios = <&pfc 326 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "S18";
+		};
+
+		back-key {
+			gpios = <&pfc 327 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			label = "S19";
+		};
+
+		volup-key {
+			gpios = <&pfc 328 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			label = "S20";
+		};
+
+		voldown-key {
+			gpios = <&pfc 329 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "S21";
+		};
+	};
 };
 
 &i2c5 {
-- 
2.1.3
