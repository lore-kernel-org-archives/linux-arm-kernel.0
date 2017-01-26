From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 26 Jan 2017 15:28:34 +0100
Subject: [PATCH v2 6/7] ARM: dts: stm32: Enable dma by default on stm32f4 adc
In-Reply-To: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1485440915-30119-7-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure STM32F4 ADC to use dma by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 8bf650d..ab42b58 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -416,6 +416,8 @@
 				clocks = <&rcc 0 168>;
 				interrupt-parent = <&adc>;
 				interrupts = <0>;
+				dmas = <&dma2 0 0 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -426,6 +428,8 @@
 				clocks = <&rcc 0 169>;
 				interrupt-parent = <&adc>;
 				interrupts = <1>;
+				dmas = <&dma2 3 1 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -436,6 +440,8 @@
 				clocks = <&rcc 0 170>;
 				interrupt-parent = <&adc>;
 				interrupts = <2>;
+				dmas = <&dma2 1 2 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 		};
-- 
1.9.1
