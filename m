From: christophe.roullier@st.com (Christophe Roullier)
Date: Wed, 23 May 2018 17:47:59 +0200
Subject: [PATCH V4 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
References: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
Message-ID: <1527090479-5263-9-git-send-email-christophe.roullier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch describes syscon DT bindings.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt            | 10 ----------
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt         | 14 ++++++++++++++
 Documentation/devicetree/bindings/arm/stm32/stm32.txt      | 10 ++++++++++
 3 files changed, 24 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
deleted file mode 100644
index 6808ed9..0000000
--- a/Documentation/devicetree/bindings/arm/stm32.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-STMicroelectronics STM32 Platforms Device Tree Bindings
-
-Each device tree must specify which STM32 SoC it uses,
-using one of the following compatible strings:
-
-  st,stm32f429
-  st,stm32f469
-  st,stm32f746
-  st,stm32h743
-  st,stm32mp157
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
diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
new file mode 100644
index 0000000..6808ed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
@@ -0,0 +1,10 @@
+STMicroelectronics STM32 Platforms Device Tree Bindings
+
+Each device tree must specify which STM32 SoC it uses,
+using one of the following compatible strings:
+
+  st,stm32f429
+  st,stm32f469
+  st,stm32f746
+  st,stm32h743
+  st,stm32mp157
-- 
1.9.1
