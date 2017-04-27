From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Apr 2017 15:24:57 +0200
Subject: [PATCH v4 1/3] Documentation/bindings: Document the SafeXel
 cryptographic engine driver
In-Reply-To: <20170427132459.23159-1-antoine.tenart@free-electrons.com>
References: <20170427132459.23159-1-antoine.tenart@free-electrons.com>
Message-ID: <20170427132459.23159-2-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Inside Secure Safexcel cryptographic engine is found on some Marvell
SoCs (7k/8k). Document the bindings used by its driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 .../bindings/crypto/inside-secure-safexcel.txt     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt

diff --git a/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
new file mode 100644
index 000000000000..ff56b9384fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
@@ -0,0 +1,27 @@
+Inside Secure SafeXcel cryptographic engine
+
+Required properties:
+- compatible: Should be "inside-secure,safexcel-eip197".
+- reg: Base physical address of the engine and length of memory mapped region.
+- interrupts: Interrupt numbers for the rings and engine.
+- interrupt-names: Should be "ring0", "ring1", "ring2", "ring3", "eip", "mem".
+
+Optional properties:
+- clocks: Reference to the crypto engine clock.
+
+Example:
+
+	crypto: crypto at 800000 {
+		compatible = "inside-secure,safexcel-eip197";
+		reg = <0x800000 0x200000>;
+		interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "mem", "ring0", "ring1", "ring2", "ring3",
+				  "eip";
+		clocks = <&cpm_syscon0 1 26>;
+		status = "disabled";
+	};
-- 
2.11.0
