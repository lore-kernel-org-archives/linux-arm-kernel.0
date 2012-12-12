From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 12 Dec 2012 15:43:05 -0600
Subject: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
The ARM Cross Trigger Interface provides a way to route events between
processor modules. For example, on OMAP4430 we use the CTI module to
route PMU events to the GIC interrupt module.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/arm/cti.txt |   32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cti.txt

diff --git a/Documentation/devicetree/bindings/arm/cti.txt b/Documentation/devicetree/bindings/arm/cti.txt
new file mode 100644
index 0000000..4a0e2d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cti.txt
@@ -0,0 +1,32 @@
+* ARM Cross Trigger Interface (CTI)
+
+The ARM Cross Trigger Interface provides a way to route events between
+processor modules. For example, debug events from one processor can be
+broadcasted to other processors. The events that can be routed between
+processors are specific to the device.
+
+Required properties:
+
+- compatible:			Should be "arm,primecell".
+- interrupts:			Interrupt associated with CTI module.
+- reg:				Contains timer register address range (base
+				address and length).
+- arm,cti-name:			A unique name for the CTI module, that will be
+				used when requesting the CTI module instance.
+
+
+Optional properties:
+
+- arm-primecell-periphid:	Primecell peripheral ID associated with CTI
+				module.
+
+
+Example:
+
+cti0: cti at 0x54148000 {
+	compatible = "arm,primecell";
+	interrupts = <0 1 0x4>;
+	reg = <0x54148000 0x1000>;
+	arm,cti-name = "cti0";
+	arm,primecell-periphid = <0x003bb906>;
+};
-- 
1.7.10.4
