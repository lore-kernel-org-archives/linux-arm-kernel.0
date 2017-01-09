From: jcsing.lee@samsung.com (Jaechul Lee)
Date: Mon, 09 Jan 2017 16:22:13 +0900
Subject: [PATCH v6 1/3] input: Add support for the tm2 touchkey device driver
In-Reply-To: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
References: <1483946535-4703-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170109072218epcas1p34a76ad70fd1d0d02c5a12e6aaac5b806@epcas1p3.samsung.com>
Message-ID: <1483946535-4703-2-git-send-email-jcsing.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the binding description of the tm2 touchkey
device driver.

Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/input/cypress,tm2-touchkey.txt        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
new file mode 100644
index 0000000..635f62c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -0,0 +1,27 @@
+Samsung tm2-touchkey
+
+Required properties:
+- compatible: must be "cypress,tm2-touchkey"
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
+			compatible = "cypress,tm2-touchkey";
+			reg = <0x20>;
+			interrupt-parent = <&gpa3>;
+			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+			vcc-supply=<&ldo32_reg>;
+			vdd-supply=<&ldo33_reg>;
+		};
+	};
-- 
2.7.4
