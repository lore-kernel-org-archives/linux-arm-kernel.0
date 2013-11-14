From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 13:02:12 -0800
Subject: [PATCH v2 1/5] Documentation: dt: Add i2c-bcm-kona binding
In-Reply-To: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
References: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <1384462936-7906-2-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding description for the i2c-bcm-kona block found on
Broadcom's mobile SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Matt Porter <matt.porter@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-bcm-kona.txt       | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt b/Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt
new file mode 100644
index 0000000..1b87b74
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt
@@ -0,0 +1,35 @@
+Broadcom Kona Family I2C
+=========================
+
+This I2C controller is used in the following Broadcom SoCs:
+
+  BCM11130
+  BCM11140
+  BCM11351
+  BCM28145
+  BCM28155
+
+Required Properties
+-------------------
+- compatible: "brcm,bcm11351-i2c", "brcm,kona-i2c"
+- reg: Physical base address and length of controller registers
+- interrupts: The interrupt number used by the controller
+- clocks: clock specifier for the kona i2c external clock
+- clock-frequency: The I2C bus frequency in Hz
+- #address-cells: Should be <1>
+- #size-cells: Should be <0>
+
+Refer to clocks/clock-bindings.txt for generic clock consumer
+properties.
+
+Example:
+
+i2c at 3e016000 {
+	compatible = "brcm,bcm11351-i2c","brcm,kona-i2c";
+	reg = <0x3e016000 0x80>;
+	interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&bsc1_clk>;
+	clock-frequency = <400000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
1.8.0.1
