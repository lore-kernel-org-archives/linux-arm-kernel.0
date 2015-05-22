From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 22 May 2015 23:03:32 +0200
Subject: [PATCH v9 1/5] dt-bindings: Document the STM32 timer bindings
In-Reply-To: <1432328616-16964-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1432328616-16964-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1432328616-16964-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
STM32 timer.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/timer/st,stm32-timer.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/st,stm32-timer.txt b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
new file mode 100644
index 0000000..8ef28e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,stm32-timer.txt
@@ -0,0 +1,22 @@
+. STMicroelectronics STM32 timer
+
+The STM32 MCUs family has several general-purpose 16 and 32 bits timers.
+
+Required properties:
+- compatible : Should be "st,stm32-timer"
+- reg : Address and length of the register set
+- clocks : Reference on the timer input clock
+- interrupts : Reference to the timer interrupt
+
+Optional properties:
+- resets: Reference to a reset controller asserting the timer
+
+Example:
+
+timer5: timer at 40000c00 {
+	compatible = "st,stm32-timer";
+	reg = <0x40000c00 0x400>;
+	interrupts = <50>;
+	resets = <&rrc 259>;
+	clocks = <&clk_pmtr1>;
+};
-- 
1.9.1
