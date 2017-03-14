From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Tue, 14 Mar 2017 17:37:23 +0100
Subject: [PATCH 1/4] dt-bindings: Document STM32 CRC bindings
In-Reply-To: <1489509446-32283-1-git-send-email-fabien.dessenne@st.com>
References: <1489509446-32283-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <1489509446-32283-2-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document device tree bindings for the STM32 CRC (crypto CRC32)

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/crypto/st,stm32-crc.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
new file mode 100644
index 0000000..2312e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
@@ -0,0 +1,16 @@
+* STMicroelectronics STM32 CRC
+
+Required properties:
+- compatible: shoudl be "st,stm32f7-crc".
+- reg: The address and length of the peripheral registers space
+- clocks: The input clock of the CRC instance
+
+Optional properties: none
+
+Example:
+
+crc: crc at 40023000 {
+	compatible = "st,stm32f7-crc";
+	reg = <0x40023000 0x400>;
+	clocks = <&rcc 0 12>;
+};
-- 
2.7.4
