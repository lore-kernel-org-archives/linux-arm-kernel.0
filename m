From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 14:28:33 +0200
Subject: [PATCH v4 1/4] dt-bindings: dma: add binding for the Marvell XOR v2
 engine
In-Reply-To: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1466080116-26777-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree binding documentation for the Marvell
XOR v2 engine, which is found on Marvell Armada 7K/8K ARM64 SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/dma/mv-xor-v2.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt

diff --git a/Documentation/devicetree/bindings/dma/mv-xor-v2.txt b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
new file mode 100644
index 0000000..217a90e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mv-xor-v2.txt
@@ -0,0 +1,24 @@
+* Marvell XOR v2 engines
+
+Required properties:
+- compatible: one of the following values:
+    "marvell,armada-7k-xor"
+    "marvell,xor-v2"
+- reg: Should contain registers location and length (two sets)
+    the first set is the DMA registers
+    the second set is the global registers
+- msi-parent: Phandle to the MSI-capable interrupt controller used for
+  interrupts.
+
+Optional properties:
+- clocks: Optional reference to the clock used by the XOR engine.
+
+Example:
+
+	xor0 at 400000 {
+		compatible = "marvell,xor-v2";
+		reg = <0x400000 0x1000>,
+		      <0x410000 0x1000>;
+		msi-parent = <&gic_v2m0>;
+		dma-coherent;
+	};
-- 
2.7.4
