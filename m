From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 17 Oct 2015 19:23:57 +0200
Subject: [PATCH 8/9] ARM: dts: Declare push button as GPIO key on stm32f429
 Disco board
In-Reply-To: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1445102638-11575-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1445102638-11575-9-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts  | 19 +++++++++++++++++++
 arch/arm/boot/dts/stm32f429-disco.dts | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 71fe17a..be21931 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "STMicroelectronics STM32429i-EVAL board";
@@ -64,6 +65,24 @@
 	aliases {
 		serial0 = &usart1;
 	};
+
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
+
+	};
 };
 
 &clk_hse {
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 532c499..2cb4c9e 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -47,6 +47,7 @@
 
 /dts-v1/;
 #include "stm32f429.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -74,6 +75,18 @@
 			gpios = <&gpiog 13 0>;
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
