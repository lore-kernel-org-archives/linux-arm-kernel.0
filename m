From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 29 May 2017 18:17:33 +0200
Subject: [PATCH v2 3/3] ARM: dts: stm32: Set gpio controller also as interrupt
 controller
In-Reply-To: <1496074653-2941-1-git-send-email-alexandre.torgue@st.com>
References: <1496074653-2941-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1496074653-2941-4-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set each gpio controller as a interrupt controller. User who
wants to use gpio as interrupt will have choice to use either "gpiolib"
interface or "common" interrupt interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index b2a2b5c..bbd725d 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -561,6 +561,8 @@
 			gpioa: gpio at 40020000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
@@ -569,6 +571,8 @@
 			gpiob: gpio at 40020400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
@@ -577,6 +581,8 @@
 			gpioc: gpio at 40020800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
@@ -585,6 +591,8 @@
 			gpiod: gpio at 40020c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
@@ -593,6 +601,8 @@
 			gpioe: gpio at 40021000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
@@ -601,6 +611,8 @@
 			gpiof: gpio at 40021400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
@@ -609,6 +621,8 @@
 			gpiog: gpio at 40021800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
@@ -617,6 +631,8 @@
 			gpioh: gpio at 40021c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
@@ -625,6 +641,8 @@
 			gpioi: gpio at 40022000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
@@ -633,6 +651,8 @@
 			gpioj: gpio at 40022400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
@@ -641,6 +661,8 @@
 			gpiok: gpio at 40022800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index c2765ce..64c6f80 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -229,6 +229,8 @@
 			gpioa: gpio at 40020000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
@@ -237,6 +239,8 @@
 			gpiob: gpio at 40020400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
@@ -245,6 +249,8 @@
 			gpioc: gpio at 40020800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
@@ -253,6 +259,8 @@
 			gpiod: gpio at 40020c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
@@ -261,6 +269,8 @@
 			gpioe: gpio at 40021000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
@@ -269,6 +279,8 @@
 			gpiof: gpio at 40021400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
@@ -277,6 +289,8 @@
 			gpiog: gpio at 40021800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
@@ -285,6 +299,8 @@
 			gpioh: gpio at 40021c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
@@ -293,6 +309,8 @@
 			gpioi: gpio at 40022000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
@@ -301,6 +319,8 @@
 			gpioj: gpio at 40022400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
@@ -309,6 +329,8 @@
 			gpiok: gpio at 40022800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
-- 
1.9.1
