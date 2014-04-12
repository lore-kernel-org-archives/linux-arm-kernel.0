From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 12 Apr 2014 23:25:54 +0200
Subject: [PATCHv2 2/7] pwm: sunxi: document OF bindings
In-Reply-To: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397337959-12408-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1397337959-12408-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the documentation for the Allwinner Socs PWM bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
new file mode 100644
index 000000000000..9eda87e7d233
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
@@ -0,0 +1,20 @@
+Allwinner PWM controller
+
+Required properties:
+  - compatible: should be one of:
+    - "allwinner,sun4i-a10-pwm"
+    - "allwinner,sun7i-a20-pwm"
+  - reg: physical base address and length of the controller's registers
+  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+  - clocks: from common clock binding, handle to the parent clock.
+
+Example:
+
+	pwm: pwm at 01c20e00 {
+		compatible = "allwinner,sun7i-a20-pwm";
+		reg = <0x01c20e00 0xc>;
+		clocks = <&osc24M>;
+		#pwm-cells = <3>;
+		status = "disabled";
+	};
-- 
1.8.3.2
