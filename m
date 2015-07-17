From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 17 Jul 2015 08:29:26 +0200
Subject: [PATCH v2 3/4] mfd: Add DT binding for Maxim MAX77802 IC
In-Reply-To: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1437114567-17629-4-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MAX77802 is a chip that contains regulators, 2 32kHz clocks,
a RTC and an I2C interface to program the individual components.

The are already DT bindings for the regulators and clocks and
these reference to a bindings/mfd/max77802.txt file, that didn't
exist, for the details about the PMIC.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes in v2:
- Use the correct "maxim,max77802" compatible string.
  Suggested by Krzysztof Kozlowski
- Use a pmic generic node name for the max77802 node example.
  Suggested by Sergei Shtylyov.

 Documentation/devicetree/bindings/mfd/max77802.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77802.txt b/Documentation/devicetree/bindings/mfd/max77802.txt
new file mode 100644
index 000000000000..c60cdec50d36
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77802.txt
@@ -0,0 +1,26 @@
+Maxim MAX77802 multi-function device
+
+The Maxim MAX77802 is a power management chip (PMIC) that contains 10 high
+efficiency Buck regulators, 32 Low-dropout (LDO) regulators used to power
+up application processors and peripherals, a 2-channel 32kHz clock outputs,
+a Real-Time-Clock (RTC) and a I2C interface to program the individual
+regulators, clocks outputs and the RTC.
+
+Binding for the built-in 32k clock generator block is defined separately
+in the bindings/clk/maxim,max77802.txt file and binding for the regulators
+is defined in the bindings/regulator/max77802.txt file.
+
+Required properties:
+- compatible : Must be "maxim,max77802";
+- reg : Specifies the i2c slave address of PMIC block.
+- interrupts : This i2c device has an IRQ line connected to the main SoC.
+- interrupt-parent : The parent interrupt controller.
+
+Example:
+
+	max77802: pmic at 09 {
+		compatible = "maxim,max77802";
+		interrupt-parent = <&intc>;
+		interrupts = <26 0>;
+		reg = <0x09>;
+	};
-- 
2.4.3
