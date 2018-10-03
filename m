From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 3 Oct 2018 17:11:03 +0200
Subject: [PATCH 1/3] ARM: dts: stm32: Add dmas to timer on stm32mp157c
In-Reply-To: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
References: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1538579465-7854-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMAs to enable PWM input capture using STM32 timers on stm32mp157c.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 58 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 661be94..17a748f 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -98,6 +98,12 @@
 			reg = <0x40000000 0x400>;
 			clocks = <&rcc TIM2_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 18 0x400 0x1>,
+			       <&dmamux1 19 0x400 0x1>,
+			       <&dmamux1 20 0x400 0x1>,
+			       <&dmamux1 21 0x400 0x1>,
+			       <&dmamux1 22 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up";
 			status = "disabled";
 
 			pwm {
@@ -119,6 +125,13 @@
 			reg = <0x40001000 0x400>;
 			clocks = <&rcc TIM3_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 23 0x400 0x1>,
+			       <&dmamux1 24 0x400 0x1>,
+			       <&dmamux1 25 0x400 0x1>,
+			       <&dmamux1 26 0x400 0x1>,
+			       <&dmamux1 27 0x400 0x1>,
+			       <&dmamux1 28 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
 			status = "disabled";
 
 			pwm {
@@ -140,6 +153,11 @@
 			reg = <0x40002000 0x400>;
 			clocks = <&rcc TIM4_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 29 0x400 0x1>,
+			       <&dmamux1 30 0x400 0x1>,
+			       <&dmamux1 31 0x400 0x1>,
+			       <&dmamux1 32 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4";
 			status = "disabled";
 
 			pwm {
@@ -161,6 +179,13 @@
 			reg = <0x40003000 0x400>;
 			clocks = <&rcc TIM5_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 55 0x400 0x1>,
+			       <&dmamux1 56 0x400 0x1>,
+			       <&dmamux1 57 0x400 0x1>,
+			       <&dmamux1 58 0x400 0x1>,
+			       <&dmamux1 59 0x400 0x1>,
+			       <&dmamux1 60 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig";
 			status = "disabled";
 
 			pwm {
@@ -182,6 +207,8 @@
 			reg = <0x40004000 0x400>;
 			clocks = <&rcc TIM6_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 69 0x400 0x1>;
+			dma-names = "up";
 			status = "disabled";
 
 			timer at 5 {
@@ -198,6 +225,8 @@
 			reg = <0x40005000 0x400>;
 			clocks = <&rcc TIM7_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 70 0x400 0x1>;
+			dma-names = "up";
 			status = "disabled";
 
 			timer at 6 {
@@ -465,6 +494,15 @@
 			reg = <0x44000000 0x400>;
 			clocks = <&rcc TIM1_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 11 0x400 0x1>,
+			       <&dmamux1 12 0x400 0x1>,
+			       <&dmamux1 13 0x400 0x1>,
+			       <&dmamux1 14 0x400 0x1>,
+			       <&dmamux1 15 0x400 0x1>,
+			       <&dmamux1 16 0x400 0x1>,
+			       <&dmamux1 17 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -486,6 +524,15 @@
 			reg = <0x44001000 0x400>;
 			clocks = <&rcc TIM8_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 47 0x400 0x1>,
+			       <&dmamux1 48 0x400 0x1>,
+			       <&dmamux1 49 0x400 0x1>,
+			       <&dmamux1 50 0x400 0x1>,
+			       <&dmamux1 51 0x400 0x1>,
+			       <&dmamux1 52 0x400 0x1>,
+			       <&dmamux1 53 0x400 0x1>;
+			dma-names = "ch1", "ch2", "ch3", "ch4",
+				    "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -543,6 +590,11 @@
 			reg = <0x44006000 0x400>;
 			clocks = <&rcc TIM15_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 105 0x400 0x1>,
+			       <&dmamux1 106 0x400 0x1>,
+			       <&dmamux1 107 0x400 0x1>,
+			       <&dmamux1 108 0x400 0x1>;
+			dma-names = "ch1", "up", "trig", "com";
 			status = "disabled";
 
 			pwm {
@@ -564,6 +616,9 @@
 			reg = <0x44007000 0x400>;
 			clocks = <&rcc TIM16_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 109 0x400 0x1>,
+			       <&dmamux1 110 0x400 0x1>;
+			dma-names = "ch1", "up";
 			status = "disabled";
 
 			pwm {
@@ -584,6 +639,9 @@
 			reg = <0x44008000 0x400>;
 			clocks = <&rcc TIM17_K>;
 			clock-names = "int";
+			dmas = <&dmamux1 111 0x400 0x1>,
+			       <&dmamux1 112 0x400 0x1>;
+			dma-names = "ch1", "up";
 			status = "disabled";
 
 			pwm {
-- 
1.9.1
