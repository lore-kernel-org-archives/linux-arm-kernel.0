From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Sat, 25 Jul 2015 23:39:35 +0200
Subject: [PATCH 2/5] Documentation: bindings: document the Berlin PWM driver
In-Reply-To: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1437860378-9556-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the addition of a Berlin PWM driver, this patch adds the
corresponding documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
new file mode 100644
index 000000000000..3d7ab7bfbf54
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
@@ -0,0 +1,15 @@
+Berlin PWM controller
+
+Required properties:
+- compatible: should be "marvell,berlin-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+
+pwm: pwm at f7f20000 {
+	compatible = "marvell,berlin-pwm";
+	reg = <0xf7f20000 0x40>;
+	#pwm-cells = <3>;
+}
-- 
2.4.6
