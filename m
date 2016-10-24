From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Mon, 24 Oct 2016 15:31:07 +0200
Subject: [PATCH] ARM: DT: STM32: add dma for usart3 on F429
Message-ID: <1477315867-21720-1-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA support for USART3 on STM32F429 MCU.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 11e8a69..0596d60 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -122,6 +122,9 @@
 			interrupts = <39>;
 			clocks = <&rcc 0 146>;
 			status = "disabled";
+			dmas = <&dma1 1 4 0x400 0x0>,
+			       <&dma1 3 4 0x400 0x0>;
+			dma-names = "rx", "tx";
 		};
 
 		usart4: serial at 40004c00 {
-- 
1.9.1
