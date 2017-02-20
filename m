From: yannick.fertre@st.com (Yannick Fertre)
Date: Mon, 20 Feb 2017 17:08:39 +0100
Subject: [PATCH v3 5/7] ARM: dts: stm32: Add ltdc support on stm32f429 MCU
In-Reply-To: <1487606921-26981-1-git-send-email-yannick.fertre@st.com>
References: <1487606921-26981-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1487606921-26981-6-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index e4dae0e..4cd8244 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -48,6 +48,8 @@
 #include "skeleton.dtsi"
 #include "armv7-m.dtsi"
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
+#include <dt-bindings/clock/stm32f4-clock.h>
+#include <dt-bindings/mfd/stm32f4-rcc.h>
 
 / {
 	clocks {
@@ -206,7 +208,7 @@
 			reg = <0x40007000 0x400>;
 		};
 
-		pin-controller {
+		pinctrl: pin-controller {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "st,stm32f429-pinctrl";
@@ -426,6 +428,21 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		ltdc: display-controller at 40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F4_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+
+			port {
+				ltdc_out_rgb: endpoint {
+				};
+			};
+		};
 	};
 };
 
-- 
1.9.1
