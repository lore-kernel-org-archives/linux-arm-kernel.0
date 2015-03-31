From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 31 Mar 2015 18:24:44 +0200
Subject: [PATCH v4 03/15] dt-bindings: Document the ARM System timer bindings
In-Reply-To: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1427819096-31109-4-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
ARM System timer.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 .../devicetree/bindings/arm/armv7m_systick.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armv7m_systick.txt

diff --git a/Documentation/devicetree/bindings/arm/armv7m_systick.txt b/Documentation/devicetree/bindings/arm/armv7m_systick.txt
new file mode 100644
index 0000000..7cf4a24
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armv7m_systick.txt
@@ -0,0 +1,26 @@
+* ARMv7M System Timer
+
+ARMv7-M includes a system timer, known as SysTick. Current driver only
+implements the clocksource feature.
+
+Required properties:
+- compatible	  : Should be "arm,armv7m-systick"
+- reg		  : The address range of the timer
+
+Required clocking property, have to be one of:
+- clocks	  : The input clock of the timer
+- clock-frequency : The rate in HZ in input of the ARM SysTick
+
+Examples:
+
+systick: timer at e000e010 {
+	compatible = "arm,armv7m-systick";
+	reg = <0xe000e010 0x10>;
+	clocks = <&clk_systick>;
+};
+
+systick: timer at e000e010 {
+	compatible = "arm,armv7m-systick";
+	reg = <0xe000e010 0x10>;
+	clock-frequency = <90000000>;
+};
-- 
1.9.1
