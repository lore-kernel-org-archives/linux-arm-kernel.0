From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 20 Feb 2015 19:01:07 +0100
Subject: [PATCH v2 08/18] dt-bindings: Document the STM32 timer bindings
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1424455277-29983-9-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
STM32 timer.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/timer/st,stm32-timer.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/st,stm32-timer.txt b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
new file mode 100644
index 0000000..7fffcd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
@@ -0,0 +1,19 @@
+. STMicroelectronics STM32 timer
+
+The STM32 MCUs family has several general-purpose 16 and 32 bits timers.
+
+Required properties:
+- compatible : Should be st,stm32-timer"
+- reg : Address and length of the register set
+- clocks : Reference on the timer input clock
+- interrupts : Reference to the timer interrupt
+
+Example:
+
+timer5: timer at 40000c00 {
+	compatible = "st,stm32-timer";
+	reg = <0x40000c00 0x400>;
+	interrupts = <50>;
+	resets = <&reset_apb1 3>;
+	clocks = <&clk_pmtr1>;
+};
-- 
1.9.1
