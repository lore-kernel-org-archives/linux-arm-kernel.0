From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 31 Mar 2016 17:09:38 +0200
Subject: [PATCH v2 8/9] ARM: dts: Declare push button as GPIO key on stm32f429
 Disco board
In-Reply-To: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1459436979-17275-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1459436979-17275-9-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts  | 18 ++++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc5959dac3..0fd78e4e8a45 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "STMicroelectronics STM32429i-EVAL board";
@@ -82,6 +83,23 @@
 		};
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		button at 0 {
+			label = "Wake up";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpioa 0 0>;
+		};
+		button at 1 {
+			label = "Tamper";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpioc 13 0>;
+		};
+	};
+
 	usbotg_hs_phy: usbphy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 01408073dd53..7d0415e80668 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -75,6 +76,18 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+		button at 0 {
+			label = "User";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpioa 0 0>;
+		};
+	};
 };
 
 &clk_hse {
-- 
1.9.1
