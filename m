From: bich.hemon@st.com (Bich HEMON)
Date: Wed, 28 Feb 2018 10:56:18 +0000
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional properties
In-Reply-To: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Message-ID: <1519815373-22940-2-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add options for enabling RS485 hardware control and configuring
Driver Enable signal:
- rs485-rts-delay
- rs485-rx-during-tx
- rs485-rts-active-low
- linux,rs485-enabled-at-boot-time

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index aaeb564..81e0011 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -16,6 +16,8 @@ Required properties:
 Optional properties:
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
+  linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 - wakeup-source: bool flag to indicate this device has wakeup capabilities
-- 
1.9.1
