From: rachna@ti.com (Patil, Rachna)
Date: Thu, 24 Jan 2013 09:15:08 +0530
Subject: [PATCH v4 4/8] MFD: ti_am335x_tscadc: add device tree binding
 information
In-Reply-To: <1358999112-31192-1-git-send-email-rachna@ti.com>
References: <1358999112-31192-1-git-send-email-rachna@ti.com>
Message-ID: <1358999112-31192-5-git-send-email-rachna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Patil, Rachna" <rachna@ti.com>

Signed-off-by: Patil, Rachna <rachna@ti.com>
---
Changes in v4:
	Subnodes and their properties documentation added.
	Non-standard properties prefixed with vendor name.

 .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
new file mode 100644
index 0000000..0100771
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
@@ -0,0 +1,52 @@
+Texas Instruments - TSC / ADC multi-functional device
+
+ti_tscadc is a multi-function device with touchscreen and ADC on chip.
+This document describes the binding for mfd device.
+
+Required properties:
+- compatible: "ti,ti-tscadc"
+- reg: Specifies the address of MFD block
+- interrupts: IRQ line connected to the main SoC
+- interrupt-parent: The parent interrupt controller
+
+Optional properties:
+- ti,hwmods: Hardware information related to TSC/ADC MFD device
+
+Sub-nodes:
+Device			Description
+------			-----------
+tsc			Touchscreen
+adc			Analog to digital converter
+
+Sub-node device required properties:
+tsc:
+- ti,wires:  4/5/8 wire touchscreen support on the platform.
+- ti,x-plate-resistance: X plate resistance.
+- ti,steps-to-configure: A step is configured to read a single co-ordinate value,
+			can be applied more number of times for better results.
+- ti,wire-config: Order for connecting wires on touchscreen.
+
+adc:
+- ti,adc-channels: Number of ADC channels used.
+
+Example:
+
+	tscadc: tscadc at 44e0d000 {
+		compatible = "ti,ti-tscadc";
+		reg = <0x44e0d000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <16>;
+		ti,hwmods = "adc_tsc";
+
+		tsc {
+			ti,wires = <4>;
+			ti,x-plate-resistance = <200>;
+			ti,steps-to-configure = <5>;
+			ti,wire-config = <0x00 0x11 0x22 0x33>;
+		};
+
+		adc {
+			ti,adc-channels = <4>;
+		};
+	};
-- 
1.7.9.5
