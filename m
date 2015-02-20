From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 20 Feb 2015 19:01:05 +0100
Subject: [PATCH v2 06/18] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1424455277-29983-7-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
STM32 reset controller.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/reset/st,stm32-reset.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/st,stm32-reset.txt b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
new file mode 100644
index 0000000..5982528
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/st,stm32-reset.txt
@@ -0,0 +1,36 @@
+STMicroelectronics STM32 Peripheral Reset Controller
+====================================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "st,stm32-reset"
+- reg: should be register base and length as documented in the
+  datasheet
+- #reset-cells: 1, see below
+
+example:
+
+reset_ahb1: reset at 40023810 {
+	#reset-cells = <1>;
+	compatible = "st,stm32-reset";
+	reg = <0x40023810 0x4>;
+};
+
+Specifying softreset control of devices
+=======================================
+
+Device nodes should specify the reset channel required in their "resets"
+property, containing a phandle to the reset device node and an index specifying
+which channel to use, as described in reset.txt
+
+example:
+
+	timer2 {
+		resets			= <&resets TIM2_RESET>;
+	};
+
+Macro definitions for the supported reset channels can be found in:
+
+include/dt-bindings/reset/st,stm32f429.h
-- 
1.9.1
