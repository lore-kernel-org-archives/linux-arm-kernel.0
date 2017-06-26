From: bich.hemon@st.com (Bich HEMON)
Date: Mon, 26 Jun 2017 12:49:09 +0000
Subject: [PATCH 02/20] dt-bindings: serial: each stm32 usart needs an alias
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Message-ID: <1498481318-1894-3-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bich Hemon <bich.hemon@st.com>

Each usart controller should have an alias correctly
numbered in "aliases" node.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 85ec5f2..a229b14 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -15,14 +15,23 @@ Optional properties:
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
+Note: Each usart controller should have an alias correctly numbered
+in "aliases" node.
+
 Examples:
-usart4: serial at 40004c00 {
+aliases {
+	serial0 = &usart1;
+	serial1 = &usart2;
+	serial3 = &uart4;
+};
+
+uart4: serial at 40004c00 {
 	compatible = "st,stm32-uart";
 	reg = <0x40004c00 0x400>;
 	interrupts = <52>;
 	clocks = <&clk_pclk1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usart4>;
+	pinctrl-0 = <&pinctrl_uart4>;
 };
 
 usart2: serial at 40004400 {
-- 
1.9.1
