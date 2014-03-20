From: tim.kryger@linaro.org (Tim Kryger)
Date: Wed, 19 Mar 2014 17:12:24 -0700
Subject: [PATCH v4 1/5] Documentation: dt: Add Kona PWM binding
In-Reply-To: <1395274348-25259-1-git-send-email-tim.kryger@linaro.org>
References: <1395274348-25259-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1395274348-25259-2-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding description for the Kona PWM controller found on Broadcom's
mobile SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/pwm/bcm-kona-pwm.txt       |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
new file mode 100644
index 0000000..8eae9fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
@@ -0,0 +1,21 @@
+Broadcom Kona PWM controller device tree bindings
+
+This controller has 6 channels.
+
+Required Properties :
+- compatible: should contain "brcm,kona-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle + clock specifier pair for the external clock
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+  description of the cells format.
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
1.7.0.4
