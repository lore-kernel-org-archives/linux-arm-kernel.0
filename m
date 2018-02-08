From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 8 Feb 2018 15:27:36 +0100
Subject: [PATCH 5/6] ARM: dts: stm32: add joystick support on stm32746g-eval
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The joystick on stm32746g-eval uses gpios on MFX gpio expander.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32746g-eval.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
index 99739f7..eb5f43b 100644
--- a/arch/arm/boot/dts/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/stm32746g-eval.dts
@@ -43,6 +43,7 @@
 /dts-v1/;
 #include "stm32f746.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/st-mfx-gpio.h>
 
 / {
 	model = "STMicroelectronics STM32746g-EVAL board";
@@ -98,6 +99,36 @@
 		};
 	};
 
+	joystick {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button at 2 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			gpios = <&mfxgpio 1 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button at 3 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			gpios = <&mfxgpio 2 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button at 4 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&mfxgpio 3 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+		button at 5 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			gpios = <&mfxgpio 4 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
+		};
+	};
 
 	mmc_vcard: mmc_vcard {
 		compatible = "regulator-fixed";
-- 
2.7.4
