From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 10 Feb 2017 15:54:47 +0100
Subject: [PATCH v2 7/9] ARM: dts: stm32: Add ltdc support on stm32f429 MCU
In-Reply-To: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
References: <1486738489-22154-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1486738489-22154-8-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 47351e2..00f6681 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -49,6 +49,7 @@
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
 #include <dt-bindings/clock/stm32f4-clock.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -432,9 +433,9 @@
 			compatible = "st,stm32-ltdc";
 			reg = <0x40016800 0x200>;
 			interrupts = <88>, <89>;
-			resets = <&rcc 314>;
+			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
 			clocks = <&rcc 1 CLK_LCD>;
-			clock-names = "clk-lcd";
+			clock-names = "lcd";
 			status = "disabled";
 
 			port {
-- 
1.9.1
