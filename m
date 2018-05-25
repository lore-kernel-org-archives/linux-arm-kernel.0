From: christophe.roullier@st.com (Christophe Roullier)
Date: Fri, 25 May 2018 09:46:41 +0200
Subject: [PATCH V0:net-next 4/4] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
References: <1527234401-15812-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1527234401-15812-5-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt         | 14 ++++++++++++++
 .../devicetree/bindings/arm/{ => stm32}/stm32.txt          |  0
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 rename Documentation/devicetree/bindings/arm/{ => stm32}/stm32.txt (100%)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
new file mode 100644
index 0000000..99980ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
@@ -0,0 +1,14 @@
+STMicroelectronics STM32 Platforms System Controller
+
+Properties:
+   - compatible : should contain two values. First value must be :
+                 - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
+                 second value must be always "syscon".
+   - reg : offset and length of the register set.
+
+ Example:
+         syscfg: syscon at 50020000 {
+                 compatible = "st,stm32mp157-syscfg", "syscon";
+                 reg = <0x50020000 0x400>;
+         };
+
diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/stm32.txt
rename to Documentation/devicetree/bindings/arm/stm32/stm32.txt
-- 
1.9.1
