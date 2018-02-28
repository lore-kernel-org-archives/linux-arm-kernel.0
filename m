From: bich.hemon@st.com (Bich HEMON)
Date: Wed, 28 Feb 2018 10:51:17 +0000
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using note
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Message-ID: <1519815044-22669-2-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update bindings with interrupt-names and wakeup-source information

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index d150b04..aaeb564 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -10,6 +10,7 @@ Required properties:
 - interrupts:
   - The interrupt line for the USART instance,
   - An optional wake-up interrupt.
+- interrupt-names: Contains "event" for the USART interrupt line.
 - clocks: The input clock of the USART instance
 
 Optional properties:
@@ -17,6 +18,9 @@ Optional properties:
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
+- wakeup-source: bool flag to indicate this device has wakeup capabilities
+- interrupt-names : Should contain "wakeup" if optional wake-up interrupt is
+  used.
 
 Examples:
 usart4: serial at 40004c00 {
-- 
1.9.1
