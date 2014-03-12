From: tim.kryger@linaro.org (Tim Kryger)
Date: Wed, 12 Mar 2014 13:15:42 -0700
Subject: [PATCH v3 1/5] Documentation: dt: Add Kona PWM binding
In-Reply-To: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1394655346-30048-2-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding description for the Kona PWM controller found on Broadcom's
mobile SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/pwm/bcm-kona-pwm.txt       | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
new file mode 100644
index 0000000..c8e2d13
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
@@ -0,0 +1,24 @@
+Broadcom Kona PWM controller device tree bindings
+
+This controller has 6 channels.
+
+Required Properties :
+- compatible: should be "brcm,kona-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle + clock specifier pair for the external clock
+- #pwm-cells: should be 3.  The first cell specifies the per-chip index
+  of the PWM to use, the second cell is the period in nanoseconds, and
+  the third cell is the flags.
+
+Refer to pwm/pwm.txt for generic pwm controller node properties.
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
+
+Example:
+
+pwm: pwm at 3e01a000 {
+	compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+	reg = <0x3e01a000 0xc4>;
+	clocks = <&pwm_clk>;
+	#pwm-cells = <3>;
+};
-- 
1.8.0.1
