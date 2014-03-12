From: mporter@linaro.org (Matt Porter)
Date: Wed, 12 Mar 2014 10:07:13 -0400
Subject: [PATCH v5 1/5] mfd: add bcm590xx pmu DT binding
In-Reply-To: <1394633237-16837-1-git-send-email-mporter@linaro.org>
References: <1394633237-16837-1-git-send-email-mporter@linaro.org>
Message-ID: <1394633237-16837-2-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding for the BCM590xx PMUs. The binding inherits from
the generic regulator bindings.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 Documentation/devicetree/bindings/mfd/bcm590xx.txt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/bcm590xx.txt

diff --git a/Documentation/devicetree/bindings/mfd/bcm590xx.txt b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
new file mode 100644
index 0000000..1fe30e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/bcm590xx.txt
@@ -0,0 +1,37 @@
+-------------------------------
+BCM590xx Power Management Units
+-------------------------------
+
+Required properties:
+- compatible: "brcm,bcm59056"
+- reg: I2C slave address
+- interrupts: interrupt for the PMU. Generic interrupt client node bindings
+  are described in interrupt-controller/interrupts.txt
+
+------------------
+Voltage Regulators
+------------------
+
+Optional child nodes:
+- regulators: container node for regulators following the generic
+  regulator binding in regulator/regulator.txt
+
+  The valid regulator node names for BCM59056 are:
+  	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
+	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr
+
+Example:
+	pmu: bcm59056 at 8 {
+		compatible = "brcm,bcm59056";
+		reg = <0x08>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+		regulators {
+			rfldo_reg: rfldo {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			...
+		};
+	};
-- 
1.8.4
