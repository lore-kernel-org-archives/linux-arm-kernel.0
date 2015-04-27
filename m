From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 27 Apr 2015 23:04:51 +0200
Subject: [PATCH v2 3/7] doc: dt: add documentation for lpc3220-timer
In-Reply-To: <1430168695-21248-1-git-send-email-manabian@gmail.com>
References: <1430168695-21248-1-git-send-email-manabian@gmail.com>
Message-ID: <1430168695-21248-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for lpc3220-timer. This timer is
used as clocksource on many NXP platforms.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/timer/nxp,lpc3220-timer.txt           | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
new file mode 100644
index 000000000000..51b05a0e70d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
@@ -0,0 +1,26 @@
+* NXP LPC3220 timer
+
+The NXP LPC3220 timer is used on a wide range of NXP SoCs. This
+includes LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
+
+Required properties:
+- compatible:
+	Should be "nxp,lpc3220-timer".
+- reg:
+	Address and length of the register set.
+- interrupts:
+	Reference to the timer interrupt
+- clocks:
+	Should contain a reference to timer clock.
+- clock-names:
+	Should contain "timerclk".
+
+Example:
+
+timer1: timer at 40085000 {
+	compatible = "nxp,lpc3220-timer";
+	reg = <0x40085000 0x1000>;
+	interrupts = <13>;
+	clocks = <&ccu1 CLK_CPU_TIMER1>;
+	clock-names = "timerclk";
+};
-- 
1.8.0
