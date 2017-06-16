From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Jun 2017 16:19:18 +0200
Subject: [PATCH v3 1/6] dt-bindings: interrupt-controller: add DT binding for
 the Marvell GICP
In-Reply-To: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
References: <20170616141923.31226-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170616141923.31226-2-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding documentation for the Marvell
GICP, an extension to the GIC that allows to trigger GIC SPI interrupts
using memory transactions. It is used by the ICU unit in the Marvell
CP110 block to turn wired interrupts inside the CP into SPI interrupts
at the GIC level in the AP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/interrupt-controller/marvell,gicp.txt | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
new file mode 100644
index 0000000..64a00ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt
@@ -0,0 +1,27 @@
+Marvell GICP Controller
+-----------------------
+
+GICP is a Marvell extension of the GIC that allows to trigger GIC SPI
+interrupts by doing a memory transaction. It is used by the ICU
+located in the Marvell CP110 to turn wired interrupts inside the CP
+into GIC SPI interrupts.
+
+Required properties:
+
+- compatible: Must be "marvell,ap806-gicp"
+
+- reg: Must be the address and size of the GICP SPI registers
+
+- marvell,spi-ranges: tuples of GIC SPI interrupts ranges available
+  for this GICP
+
+- msi-controller: indicates that this is an MSI controller
+
+Example:
+
+gicp_spi: gicp-spi at 3f0040 {
+	compatible = "marvell,ap806-gicp";
+	reg = <0x3f0040 0x10>;
+	marvell,spi-ranges = <64 64>, <288 64>;
+	msi-controller;
+};
-- 
2.9.4
