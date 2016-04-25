From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Apr 2016 09:45:43 +0100
Subject: [PATCH 1/2] dt-bindings: document the MPS2 timer bindings
In-Reply-To: <1461573944-2728-1-git-send-email-vladimir.murzin@arm.com>
References: <1461573944-2728-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461573944-2728-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
timers found on ARM MPS2 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 .../devicetree/bindings/timer/arm,mps2-timer.txt   |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,mps2-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt b/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
new file mode 100644
index 0000000..48f84d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
@@ -0,0 +1,28 @@
+ARM MPS2 timer
+
+The MPS2 platform has simple general-purpose 32 bits timers.
+
+Required properties:
+- compatible	: Should be "arm,mps2-timer"
+- reg		: Address and length of the register set
+- interrupts	: Reference to the timer interrupt
+
+Required clocking property, have to be one of:
+- clocks	  : The input clock of the timer
+- clock-frequency : The rate in HZ in input of the ARM MPS2 timer
+
+Examples:
+
+timer1: mps2-timer at 40000000 {
+	compatible = "arm,mps2-timer";
+	reg = <0x40000000 0x1000>;
+	interrupts = <8>;
+	clocks = <&sysclk>;
+};
+
+timer2: mps2-timer at 40001000 {
+	compatible = "arm,mps2-timer";
+	reg = <0x40001000 0x1000>;
+	interrupts = <9>;
+	clock-frequency = <25000000>;
+};
-- 
1.7.9.5
