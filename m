From: lionel.debieve@st.com (Lionel Debieve)
Date: Thu, 13 Jul 2017 15:32:26 +0200
Subject: [PATCH 1/2] dt-bindings: Document STM32 HASH bindings
In-Reply-To: <1499952747-16423-1-git-send-email-lionel.debieve@st.com>
References: <1499952747-16423-1-git-send-email-lionel.debieve@st.com>
Message-ID: <1499952747-16423-2-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the STM32
HASH controller.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 .../devicetree/bindings/crypto/st,stm32-hash.txt   | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.txt

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-hash.txt b/Documentation/devicetree/bindings/crypto/st,stm32-hash.txt
new file mode 100644
index 0000000..04fc246
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-hash.txt
@@ -0,0 +1,30 @@
+* STMicroelectronics STM32 HASH
+
+Required properties:
+- compatible: Should contain entries for this and backward compatible
+  HASH versions:
+  - "st,stm32f456-hash" for stm32 F456.
+  - "st,stm32f756-hash" for stm32 F756.
+- reg: The address and length of the peripheral registers space
+- interrupts: the interrupt specifier for the HASH
+- clocks: The input clock of the HASH instance
+
+Optional properties:
+- resets: The input reset of the HASH instance
+- dmas: DMA specifiers for the HASH. See the DMA client binding,
+	 Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request name. Should be "in" if a dma is present.
+- dma-maxburst: Set number of maximum dma burst supported
+
+Example:
+
+hash1: hash at 50060400 {
+	compatible = "st,stm32f756-hash";
+	reg = <0x50060400 0x400>;
+	interrupts = <80>;
+	clocks = <&rcc 0 STM32F7_AHB2_CLOCK(HASH)>;
+	resets = <&rcc STM32F7_AHB2_RESET(HASH)>;
+	dmas = <&dma2 7 2 0x400 0x0>;
+	dma-names = "in";
+	dma-maxburst = <0>;
+};
-- 
2.7.4
