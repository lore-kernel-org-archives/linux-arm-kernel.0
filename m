From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 19 Oct 2012 23:38:55 +1300
Subject: [PATCH 3/3] DOC: PWM: Adding binding document for via,vt8500-pwm
In-Reply-To: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
References: <1350643135-13197-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1350643135-13197-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a binding document describing the PWM controller found
on arch-vt8500 supported SoCs.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/pwm/vt8500-pwm.txt         |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
new file mode 100644
index 0000000..e8ba133
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
@@ -0,0 +1,17 @@
+VIA/Wondermedia VT8500/WM8xxx series SoC PWM controller
+
+Required properties:
+- compatible: should be "via,vt8500-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 2.  The first cell specifies the per-chip index
+  of the PWM to use and the second cell is the period in nanoseconds.
+- clocks: pHandle to the PWM source clock
+
+Example:
+
+pwm1: pwm at d8220000 {
+	#pwm-cells = <2>;
+	compatible = "via,vt8500-pwm";
+	reg = <0xd8220000 0x1000>;
+	clocks = <&clkpwm>;
+};
-- 
1.7.9.5
