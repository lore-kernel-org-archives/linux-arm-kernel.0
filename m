From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 Aug 2017 11:33:02 +0200
Subject: [PATCH 3/7] ARM: dts: stm32: Add USB HS support for STM32F746 MCU
In-Reply-To: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1502962386-6683-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the USB pins and nodes for USB HS core on STM32F746 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index 5633860..fcfe5a6 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -379,6 +379,46 @@
 					bias-disable;
 				};
 			};
+
+			usbotg_hs_pins_a: usbotg_hs at 0 {
+				pins {
+					pinmux = <STM32F746_PH4_FUNC_OTG_HS_ULPI_NXT>,
+						 <STM32F746_PI11_FUNC_OTG_HS_ULPI_DIR>,
+						 <STM32F746_PC0_FUNC_OTG_HS_ULPI_STP>,
+						 <STM32F746_PA5_FUNC_OTG_HS_ULPI_CK>,
+						 <STM32F746_PA3_FUNC_OTG_HS_ULPI_D0>,
+						 <STM32F746_PB0_FUNC_OTG_HS_ULPI_D1>,
+						 <STM32F746_PB1_FUNC_OTG_HS_ULPI_D2>,
+						 <STM32F746_PB10_FUNC_OTG_HS_ULPI_D3>,
+						 <STM32F746_PB11_FUNC_OTG_HS_ULPI_D4>,
+						 <STM32F746_PB12_FUNC_OTG_HS_ULPI_D5>,
+						 <STM32F746_PB13_FUNC_OTG_HS_ULPI_D6>,
+						 <STM32F746_PB5_FUNC_OTG_HS_ULPI_D7>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
+
+			usbotg_hs_pins_b: usbotg_hs at 1 {
+				pins {
+					pinmux = <STM32F746_PH4_FUNC_OTG_HS_ULPI_NXT>,
+						 <STM32F746_PC2_FUNC_OTG_HS_ULPI_DIR>,
+						 <STM32F746_PC0_FUNC_OTG_HS_ULPI_STP>,
+						 <STM32F746_PA5_FUNC_OTG_HS_ULPI_CK>,
+						 <STM32F746_PA3_FUNC_OTG_HS_ULPI_D0>,
+						 <STM32F746_PB0_FUNC_OTG_HS_ULPI_D1>,
+						 <STM32F746_PB1_FUNC_OTG_HS_ULPI_D2>,
+						 <STM32F746_PB10_FUNC_OTG_HS_ULPI_D3>,
+						 <STM32F746_PB11_FUNC_OTG_HS_ULPI_D4>,
+						 <STM32F746_PB12_FUNC_OTG_HS_ULPI_D5>,
+						 <STM32F746_PB13_FUNC_OTG_HS_ULPI_D6>,
+						 <STM32F746_PB5_FUNC_OTG_HS_ULPI_D7>;
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
 		};
 
 		crc: crc at 40023000 {
@@ -431,6 +471,15 @@
 			st,mem2mem;
 			status = "disabled";
 		};
+
+		usbotg_hs: usb at 40040000 {
+			compatible = "st,stm32f7xx-hsotg";
+			reg = <0x40040000 0x40000>;
+			interrupts = <77>;
+			clocks = <&rcc 0 STM32F7_AHB1_CLOCK(OTGHS)>;
+			clock-names = "otg";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.7.4
