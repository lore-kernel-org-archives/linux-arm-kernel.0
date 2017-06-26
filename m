From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:15 +0000
Subject: [PATCH 14/20] dt-bindings: serial: document option wake-up interrupt
 for STM32 USART
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-15-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Introduce new compatibles for "st,stm32h7-usart" and "st,stm32h7-uart".
This new compatible allow to use optional wake-up interrupt.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt    | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index a229b14..3b42138 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -2,11 +2,14 @@
 
 Required properties:
 - compatible: Can be either "st,stm32-usart", "st,stm32-uart",
-"st,stm32f7-usart" or "st,stm32f7-uart" depending on whether
-the device supports synchronous mode and is compatible with
-stm32(f4) or stm32f7.
+"st,stm32f7-usart", "st,stm32f7-uart", "st,stm32h7-usart" or
+st,stm32h7-uart depending on whether the device supports synchronous
+mode and is compatible with stm32(f4), stm32f7 or stm32h7.
 - reg: The address and length of the peripheral registers space
-- interrupts: The interrupt line of the USART instance
+- interrupts or interrupts-extended: Must contain first, the interrupt
+  line specifier for the USART instance. An optional wake-up interrupt
+  specifier can be added. Then, -extended variant may be needed to specify
+  interrupts parent controllers.
 - clocks: The input clock of the USART instance
 
 Optional properties:
@@ -53,3 +56,12 @@ usart1: serial at 40011000 {
 	       <&dma2 7 4 0x414 0x0>;
 	dma-names = "rx", "tx";
 };
+
+uart4: serial at 40010000 {
+	compatible = "st,stm32h7-uart";
+	reg = <0x40010000 0x400>;
+	interrupts-extended = <&intc GIC_SPI 52 IRQ_TYPE_NONE>,
+			      <&aiec 30 1>;
+	clocks = <&rcc UART4_K>;
+	status = "disabled";
+};
-- 
1.9.1
