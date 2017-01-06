From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Fri, 06 Jan 2017 12:59:07 +0900
Subject: [PATCH v3 3/5] input: Add support for the tm2 touchkey device driver
In-Reply-To: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035914epcas5p2954865ce8060c6aaee61a7526e417b7d@epcas5p2.samsung.com>
Message-ID: <1483675149-32598-4-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding description of the tm2 touchkey
device driver.

Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/samsung,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
new file mode 100644
index 0000000..4de1af0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/samsung,tm2-touchkey.txt
@@ -0,0 +1,27 @@
+Samsung tm2-touchkey
+
+Required properties:
+- compatible: must be "samsung,tm2-touchkey"
+- reg: I2C address of the chip.
+- interrupt-parent: a phandle for the interrupt controller (see interrupt
+	binding[0]).
+- interrupts: interrupt to which the chip is connected (see interrupt
+	binding[0]).
+- vcc-supply : internal regulator output. 1.8V
+- vdd-supply : power supply for IC 3.3V
+
+[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+	&i2c0 {
+		/* ... */
+
+		touchkey at 20 {
+			compatible = "samsung,tm2-touchkey";
+			reg = <0x20>;
+			interrupt-parent = <&gpa3>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+			vcc-supply=<&ldo32_reg>;
+			vdd-supply=<&ldo33_reg>;
+		};
+	};
-- 
2.7.4
