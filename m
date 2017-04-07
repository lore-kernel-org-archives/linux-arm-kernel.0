From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 17:10:11 +0200
Subject: [PATCH 4/4] ARM: dts: stm32: Set gpio controller also as interrupt
 controller
In-Reply-To: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
References: <1491577811-26989-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491577811-26989-5-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set each gpio controller as a interrupt controller. User who
wants to use gpio as interrupt will have choice to use either "gpiolib"
interface or "common" interrupt interface.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index ee0da97..12c6b70 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -555,6 +555,8 @@
 			gpioa: gpio at 40020000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
@@ -563,6 +565,8 @@
 			gpiob: gpio at 40020400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
@@ -571,6 +575,8 @@
 			gpioc: gpio at 40020800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
@@ -579,6 +585,8 @@
 			gpiod: gpio at 40020c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
@@ -587,6 +595,8 @@
 			gpioe: gpio at 40021000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
@@ -595,6 +605,8 @@
 			gpiof: gpio at 40021400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
@@ -603,6 +615,8 @@
 			gpiog: gpio at 40021800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
@@ -611,6 +625,8 @@
 			gpioh: gpio at 40021c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
@@ -619,6 +635,8 @@
 			gpioi: gpio at 40022000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
@@ -627,6 +645,8 @@
 			gpioj: gpio at 40022400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
@@ -635,6 +655,8 @@
 			gpiok: gpio at 40022800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 STM32F4_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index f321ffe..8f2525f 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -190,6 +190,8 @@
 			gpioa: gpio at 40020000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 256>;
 				st,bank-name = "GPIOA";
@@ -198,6 +200,8 @@
 			gpiob: gpio at 40020400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 257>;
 				st,bank-name = "GPIOB";
@@ -206,6 +210,8 @@
 			gpioc: gpio at 40020800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 258>;
 				st,bank-name = "GPIOC";
@@ -214,6 +220,8 @@
 			gpiod: gpio at 40020c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 259>;
 				st,bank-name = "GPIOD";
@@ -222,6 +230,8 @@
 			gpioe: gpio at 40021000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 260>;
 				st,bank-name = "GPIOE";
@@ -230,6 +240,8 @@
 			gpiof: gpio at 40021400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 261>;
 				st,bank-name = "GPIOF";
@@ -238,6 +250,8 @@
 			gpiog: gpio at 40021800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 262>;
 				st,bank-name = "GPIOG";
@@ -246,6 +260,8 @@
 			gpioh: gpio at 40021c00 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 263>;
 				st,bank-name = "GPIOH";
@@ -254,6 +270,8 @@
 			gpioi: gpio at 40022000 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 264>;
 				st,bank-name = "GPIOI";
@@ -262,6 +280,8 @@
 			gpioj: gpio at 40022400 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 265>;
 				st,bank-name = "GPIOJ";
@@ -270,6 +290,8 @@
 			gpiok: gpio at 40022800 {
 				gpio-controller;
 				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 266>;
 				st,bank-name = "GPIOK";
-- 
1.9.1
