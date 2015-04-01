From: manabian@gmail.com (Joachim Eastwood)
Date: Wed,  1 Apr 2015 23:20:40 +0200
Subject: [PATCH 3/6] doc: dt: add documentation for lpc3250-timer
In-Reply-To: <1427923243-26296-1-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
Message-ID: <1427923243-26296-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for lpc3250-timer. This timer is
used as clocksource on many NXP platforms.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../bindings/timer/nxp,lpc3250-timer.txt           | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3250-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,lpc3250-timer.txt b/Documentation/devicetree/bindings/timer/nxp,lpc3250-timer.txt
new file mode 100644
index 000000000000..9381c3e1d5aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,lpc3250-timer.txt
@@ -0,0 +1,25 @@
+* NXP LPC3250 timer
+
+The NXP LPC3250 timer is used on a wide range of NXP SoCs. This
+includes LPC32xx, LPC178x, LPC18xx and LPC43xx parts.
+
+Required properties:
+- compatible:
+	Should be "nxp,lpc3250-timer".
+- reg:
+	Address and length of the register set.
+- interrupts:
+	Reference to the timer interrupt
+- clocks:
+	Should contain a reference to the timer clock.
+
+
+Example:
+
+timer1: timer at 40085000 {
+	compatible = "nxp,lpc3250-timer";
+	reg = <0x40085000 0x1000>;
+	interrupts = <13>;
+	clocks = <&ccu1 CLK_CPU_TIMER1>;
+};
+
-- 
1.8.0
