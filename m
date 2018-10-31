From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 31 Oct 2018 10:30:28 +0100
Subject: [PATCH 1/5] dt-bindings: hwlock: Document STM32 hwspinlock bindings
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Message-ID: <20181031093032.20386-2-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for STM32 hardware spinlock device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt

diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
new file mode 100644
index 000000000000..7a999479d802
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
@@ -0,0 +1,23 @@
+STM32 Hardware Spinlock Device Binding
+-------------------------------------
+
+Required properties :
+- compatible : should be "st,stm32-hwspinlock".
+- reg : the register address of hwspinlock.
+- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
+	hwlock, so the number of cells should be <1> here.
+- clock-names : Must contain "hwspinlock".
+- clocks : Must contain a phandle entry for the clock in clock-names, see the
+	common clock bindings.
+
+Please look at the generic hwlock binding for usage information for consumers,
+"Documentation/devicetree/bindings/hwlock/hwlock.txt"
+
+Example of hwlock provider:
+	hwspinlock at 4c000000 {
+		compatible = "st,stm32-hwspinlock";
+		#hwlock-cells = <1>;
+		reg = <0x4c000000 0x400>;
+		clocks = <&rcc HSEM>;
+		clock-names = "hwspinlock";
+	};
-- 
2.15.0
