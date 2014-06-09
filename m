From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon,  9 Jun 2014 21:03:58 +0400
Subject: [PATCH 2/2] clocksource: clps711x: Add DT bindings documentation
Message-ID: <1402333438-13731-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT binding documentation for the Cirrus Logic
CLPS711X-based CPUs clocksource subsystem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/timer/cirrus,clps711x-timer.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
new file mode 100644
index 0000000..cd55b52
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
@@ -0,0 +1,29 @@
+* Cirrus Logic CLPS711X Timer Counter
+
+Required properties:
+- compatible: Shall contain "cirrus,clps711x-timer".
+- reg       : Address and length of the register set.
+- interrupts: The interrupt number of the timer.
+- clocks    : phandle of timer reference clock.
+
+Note: Each timer should have an alias correctly numbered in "aliases" node.
+
+Example:
+	aliases {
+		timer0 = &timer1;
+		timer1 = &timer2;
+	};
+
+	timer1: timer at 80000300 {
+		compatible = "cirrus,ep7312-timer", "cirrus,clps711x-timer";
+		reg = <0x80000300 0x4>;
+		interrupts = <8>;
+		clocks = <&clks 5>;
+	};
+
+	timer2: timer at 80000340 {
+		compatible = "cirrus,ep7312-timer", "cirrus,clps711x-timer";
+		reg = <0x80000340 0x4>;
+		interrupts = <9>;
+		clocks = <&clks 6>;
+	};
-- 
1.8.5.5
