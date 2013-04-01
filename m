From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:23 -0500
Subject: [PATCH v2 13/13] devtree: add binding documentation for sp804
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-14-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <haojian.zhuang@linaro.org>

The sp804 binding is already in use by several platforms. This adds missing
documentation for the binding and also extends the binding to handle some
additional possible interrupt configurations.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 .../devicetree/bindings/timer/arm,sp804.txt        |   29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
new file mode 100644
index 0000000..5cd8eee
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
@@ -0,0 +1,29 @@
+ARM sp804 Dual Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "arm,sp804" & "arm,primecell"
+- interrupts: Should contain the list of Dual Timer interrupts. This is the
+	interrupt for timer 1 and timer 2. In the case of a single entry, it is
+	the combined interrupt or if "arm,sp804-has-irq" is present that
+	specifies which timer interrupt is connected.
+- reg: Should contain location and length for dual timer register.
+- clocks: clocks driving the dual timer hardware. This list should be 1 or 3
+	clocks.	With 3 clocks, the order is timer0 clock, timer1 clock,
+	apb_pclk. A single clock can also be specified if the same clock is
+	used for all clock inputs.
+
+Optional properties:
+- arm,sp804-has-irq = <#>: In the case of only 1 timer irq line connected, this
+	specifies if the irq connection is for timer 1 or timer 2. A value of 1
+	or 2 should be used.
+
+Example:
+
+	timer0: timer at fc800000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0xfc800000 0x1000>;
+		interrupts = <0 0 4>, <0 1 4>;
+		clocks = <&timclk1 &timclk2 &pclk>;
+		clock-names = "timer1", "timer2", "apb_pclk";
+	};
-- 
1.7.10.4
