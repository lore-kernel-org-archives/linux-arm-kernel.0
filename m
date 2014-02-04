From: mporter@linaro.org (Matt Porter)
Date: Tue,  4 Feb 2014 07:19:08 -0500
Subject: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
In-Reply-To: <1391516352-32359-1-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Message-ID: <1391516352-32359-3-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding for the BCM59056 PMU. The binding inherits from
the generic regulator bindings.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/regulator/bcm59056.txt     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/bcm59056.txt

diff --git a/Documentation/devicetree/bindings/regulator/bcm59056.txt b/Documentation/devicetree/bindings/regulator/bcm59056.txt
new file mode 100644
index 0000000..bf6b633
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/bcm59056.txt
@@ -0,0 +1,37 @@
+BCM59056 Power Management Unit
+
+Required properties:
+- compatible: "brcm,bcm59056"
+- reg: I2C slave address
+- interrupts: interrupt for the PMU. Generic interrupt client node bindings
+  are described in interrupt-controller/interrupts.txt
+- regulators: This is the list of child nodes that specify the regulator
+  initialization data for defined regulators.  Generic regulator bindings
+  are described in regulator/regulator.txt.
+
+  The valid regulator-compatible values are:
+  	rfldo, camldo1, camldo2, simldo1, simlso2, sdldo, sdxldo,
+	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr
+
+Example:
+	pmu: bcm59056 at 8 {
+		compatible = "brcm,bcm59056";
+		reg = <0x08>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rfldo_reg: regulator at 0 {
+				reg = <0>;
+				regulator-compatible = "rfldo";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			...
+		};
+	};
-- 
1.8.4
