From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Fri, 5 May 2017 17:31:22 +0200
Subject: [PATCH v5 3/8] ARM: dts: stm32: Enable DCMI support on STM32F429 MCU
In-Reply-To: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
References: <1493998287-5828-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1493998287-5828-4-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DCMI camera interface on STM32F429 MCU.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index ee0da97..e1ff978 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -736,6 +736,29 @@
 					slew-rate = <3>;
 				};
 			};
+
+			dcmi_pins: dcmi_pins at 0 {
+				pins {
+					pinmux = <STM32F429_PA4_FUNC_DCMI_HSYNC>,
+						 <STM32F429_PB7_FUNC_DCMI_VSYNC>,
+						 <STM32F429_PA6_FUNC_DCMI_PIXCLK>,
+						 <STM32F429_PC6_FUNC_DCMI_D0>,
+						 <STM32F429_PC7_FUNC_DCMI_D1>,
+						 <STM32F429_PC8_FUNC_DCMI_D2>,
+						 <STM32F429_PC9_FUNC_DCMI_D3>,
+						 <STM32F429_PC11_FUNC_DCMI_D4>,
+						 <STM32F429_PD3_FUNC_DCMI_D5>,
+						 <STM32F429_PB8_FUNC_DCMI_D6>,
+						 <STM32F429_PE6_FUNC_DCMI_D7>,
+						 <STM32F429_PC10_FUNC_DCMI_D8>,
+						 <STM32F429_PC12_FUNC_DCMI_D9>,
+						 <STM32F429_PD6_FUNC_DCMI_D10>,
+						 <STM32F429_PD2_FUNC_DCMI_D11>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+			};
 		};
 
 		rcc: rcc at 40023810 {
@@ -805,6 +828,20 @@
 			status = "disabled";
 		};
 
+		dcmi: dcmi at 50050000 {
+			compatible = "st,stm32-dcmi";
+			reg = <0x50050000 0x400>;
+			interrupts = <78>;
+			resets = <&rcc STM32F4_AHB2_RESET(DCMI)>;
+			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(DCMI)>;
+			clock-names = "mclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&dcmi_pins>;
+			dmas = <&dma2 1 1 0x414 0x3>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		rng: rng at 50060800 {
 			compatible = "st,stm32-rng";
 			reg = <0x50060800 0x400>;
-- 
1.9.1
