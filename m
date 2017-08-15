From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 15 Aug 2017 09:19:43 +0200
Subject: [PATCH v2 2/3] dt-bindings: Document STM32 CRYP bindings
In-Reply-To: <1502781584-18468-1-git-send-email-fabien.dessenne@st.com>
References: <1502781584-18468-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <1502781584-18468-3-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document device tree bindings for the STM32 CRYP.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/crypto/st,stm32-cryp.txt     | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt b/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
new file mode 100644
index 0000000..7c6d599
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
@@ -0,0 +1,20 @@
+* STMicroelectronics STM32 CRYP
+
+Required properties:
+- compatible: Should be "st,stm32f756-cryp".
+- reg: The address and length of the peripheral registers space
+- clocks: The input clock of the CRYP instance
+- interrupts: The CRYP interrupt
+
+Optional properties:
+- resets: The input reset of the CRYP instance
+
+Example:
+cryp1: cryp at 50060000 {
+	compatible = "st,stm32f756-cryp";
+	reg = <0x50060000 0x400>;
+	interrupts = <79>;
+	clocks = <&rcc 0 STM32F7_AHB2_CLOCK(CRYP)>;
+	resets = <&rcc STM32F7_AHB2_RESET(CRYP)>;
+	status = "disabled";
+};
-- 
2.7.4
