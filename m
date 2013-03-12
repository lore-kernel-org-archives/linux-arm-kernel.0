From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:43 +0800
Subject: [PATCH v2 14/14] Document: add device tree binding file for sp804
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-15-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding document for sp804 dual timer.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 .../devicetree/bindings/timer/arm,sp804.txt        |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
new file mode 100644
index 0000000..ec1ae45
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
@@ -0,0 +1,27 @@
+ARM sp804 Dual Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "arm,sp804" & "arm,primecell"
+- interrupts: Should contain the list of Dual Timer interrupts
+	interrupts = <0 0 4>, <0 1 4>;
+- reg: Should contain location and length for dual timer register.
+- clocks: clock driving the dual timer hardware
+	clocks = <&timclk0 &timclk1>;
+
+Optional properties:
+- arm,sp804-clocksource: Should contain the register offset of TIMER1 or
+  TIMER2 in Dual Timer Controller.
+	arm,sp804-clocksource = <0x20>;
+
+Example:
+
+	timer0: timer at fc800000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0xfc800000 0x1000>;
+		/* timer00 & timer01 */
+		interrupts = <0 0 4>, <0 1 4>;
+		clocks = <&timclk0 &timclk1>;
+		clock-names = "apb_pclk";
+		status = "disabled";
+	};
-- 
1.7.10.4
