From: jagan@openedev.com (Jagan Teki)
Date: Wed, 22 Mar 2017 16:36:47 +0530
Subject: [PATCH v7 2/3] dt-bindings: input: touchscreen: Add max11801-ts
 binding
In-Reply-To: <1490180808-2856-1-git-send-email-jagan@openedev.com>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
Message-ID: <1490180808-2856-2-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add missing documentation of max11801-ts dt-binding details.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
- add vendor prefix as maxim
Changes for v6:
- Replace the lable and name of the node
   ts: max11801 => max11801: touchscreen at 48
Changes for v5:
- Newly added patch

 .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
new file mode 100644
index 0000000..8a6cb95
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
@@ -0,0 +1,18 @@
+* MAXI MAX11801 Resistive touch screen controller with i2c interface
+
+Required properties:
+- compatible: must be "maxim,max11801"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+
+Example:
+
+&i2c1 {
+	max11801: touchscreen at 48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 2>;
+	};
+};
-- 
1.9.1
