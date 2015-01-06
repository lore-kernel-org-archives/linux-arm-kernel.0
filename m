From: dhdang@apm.com (Duc Dang)
Date: Tue,  6 Jan 2015 08:15:43 -0800
Subject: [PATCH 3/4] documentation: dts: Add the device tree binding for APM
 X-Gene v1 PCIe MSI device tree node.
In-Reply-To: <cover.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
Message-ID: <33cd03155176a77c673eee4a4598e677a3a9b8b4.1420499393.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver for this binding is under 'drivers/pci/host/pci-xgene-msi.c'

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
---
 .../devicetree/bindings/pci/xgene-pci-msi.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt

diff --git a/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
new file mode 100644
index 0000000..386782c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
@@ -0,0 +1,34 @@
+* AppliedMicro X-Gene PCIe MSI interface
+
+Required properties:
+
+- compatible: should contain "apm,xgene-pcie-msi" or "apm,xgene-storm-pcie-msi"
+	to identify the core.
+- reg: A list of physical base address and length for each set of controller
+       registers.
+- interrupts: A list of interrupt outputs of the controller.
+
+Examples:
+
+SoC DTSI:
+
+	msi at 79000000 {
+	     compatible = "apm,xgene-storm-pcie-msi", "apm,xgene-pcie-msi";
+	     reg = <0x00 0x79000000 0x0 0x900000>;
+	     interrupts = <  0x0 0x10 0x4
+		     0x0 0x11 0x4
+		     0x0 0x12 0x4
+		     0x0 0x13 0x4
+		     0x0 0x14 0x4
+		     0x0 0x15 0x4
+		     0x0 0x16 0x4
+		     0x0 0x17 0x4
+		     0x0 0x18 0x4
+		     0x0 0x19 0x4
+		     0x0 0x1a 0x4
+		     0x0 0x1b 0x4
+		     0x0 0x1c 0x4
+		     0x0 0x1d 0x4
+		     0x0 0x1e 0x4
+		     0x0 0x1f 0x4>;
+	};
-- 
1.9.1
