From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 25 Oct 2016 18:25:22 +0200
Subject: [PATCH 10/10] ARM: dts: stm32f429: Add dma support to adc
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1477412722-24061-11-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure STM32 ADC to use dma by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 3fcd941..a00f7a6 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -186,6 +186,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x0>;
 				clocks = <&rcc 0 168>;
+				dmas = <&dma2 0 0 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -201,6 +203,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x100>;
 				clocks = <&rcc 0 169>;
+				dmas = <&dma2 3 1 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -216,6 +220,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x200>;
 				clocks = <&rcc 0 170>;
+				dmas = <&dma2 1 2 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
-- 
1.9.1
