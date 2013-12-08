From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  8 Dec 2013 16:48:07 +0100
Subject: [PATCH] ARM: DT: Dove: Use symbolic names from gpio.h
Message-ID: <1386517687-28820-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace 0 and 1 with GPIO_ACTIVE_HIGH, GPIO_ACTIVE_LOW

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/dove-cubox.dts  |  8 ++++----
 arch/arm/boot/dts/dove-d2plug.dts |  6 +++---
 arch/arm/boot/dts/dove-d3plug.dts | 12 ++++++------
 arch/arm/boot/dts/dove.dtsi       |  1 +
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 7a70f4ca502a..66eab1836ebf 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -22,7 +22,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpio0 18 1>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 	};
@@ -41,7 +41,7 @@
 			enable-active-high;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 1 0>;
+			gpio = <&gpio0 1 GPIO_ACTIVE_HIGH>;
 			pinctrl-0 = <&pmx_gpio_1>;
 			pinctrl-names = "default";
 		};
@@ -58,7 +58,7 @@
 
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio0 19 1>;
+		gpios = <&gpio0 19 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&pmx_gpio_19>;
 		pinctrl-names = "default";
 	};
@@ -112,7 +112,7 @@
 &sdio0 {
 	status = "okay";
 	/* sdio0 card detect is connected to wrong pin on CuBox */
-	cd-gpios = <&gpio0 12 1>;
+	cd-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&pmx_sdio0 &pmx_gpio_12>;
 };
 
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/dove-d2plug.dts
index c11d3636c8e5..3c1fde81c1e0 100644
--- a/arch/arm/boot/dts/dove-d2plug.dts
+++ b/arch/arm/boot/dts/dove-d2plug.dts
@@ -22,17 +22,17 @@
 
 		wlan-ap {
 			label = "wlan-ap";
-			gpios = <&gpio0 0 1>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
 		};
 
 		wlan-act {
 			label = "wlan-act";
-			gpios = <&gpio0 1 1>;
+			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
 		};
 
 		bluetooth-act {
 			label = "bt-act";
-			gpios = <&gpio0 2 1>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/dove-d3plug.dts
index f5f59bb5a534..a31efaa2edd2 100644
--- a/arch/arm/boot/dts/dove-d3plug.dts
+++ b/arch/arm/boot/dts/dove-d3plug.dts
@@ -22,17 +22,17 @@
 
 		wlan-act {
 			label = "wlan-act";
-			gpios = <&gpio0 0 1>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
 		};
 
 		wlan-ap {
 			label = "wlan-ap";
-			gpios = <&gpio0 1 1>;
+			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
 		};
 
 		status {
 			label = "status";
-			gpios = <&gpio0 2 1>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -50,7 +50,7 @@
 			enable-active-high;
 			regulator-always-on;
 			regulator-boot-on;
-			gpio = <&gpio0 8 0>;
+			gpio = <&gpio0 8 GPIO_ACTIVE_HIGH>;
 			pinctrl-0 = <&pmx_gpio_8>;
 			pinctrl-names = "default";
 		};
@@ -90,7 +90,7 @@
 	/* Fresco Logic USB3.0 xHCI controller */
 	pcie-port at 0 {
 		status = "okay";
-		reset-gpios = <&gpio0 26 1>;
+		reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
 		reset-delay-us = <20000>;
 		pinctrl-0 = <&pmx_camera_gpio>;
 		pinctrl-names = "default";
@@ -98,6 +98,6 @@
 	/* Mini-PCIe slot */
 	pcie-port at 1 {
 		status = "okay";
-		reset-gpios = <&gpio0 25 1>;
+		reset-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index db24b41a5264..bad0decdfc83 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -1,4 +1,5 @@
 /include/ "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
-- 
1.8.5
