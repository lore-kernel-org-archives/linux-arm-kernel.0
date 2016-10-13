From: youlin.pei@mediatek.com (Youlin Pei)
Date: Thu, 13 Oct 2016 13:06:32 +0800
Subject: [PATCH 1/3] binding: irqchip: mtk-cirq: Add binding document
In-Reply-To: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
References: <1476335194-26604-1-git-send-email-youlin.pei@mediatek.com>
Message-ID: <1476335194-26604-2-git-send-email-youlin.pei@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the device tree binding document for
the mediatek cirq.

Signed-off-by: Youlin Pei <youlin.pei@mediatek.com>

---
base on v4.8-rc1
---
 .../interrupt-controller/mediatek,cirq.txt         |   30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
new file mode 100644
index 0000000..ad16953
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,cirq.txt
@@ -0,0 +1,30 @@
+* Mediatek 27xx cirq
+
+In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
+works outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
+The external interrupts (outside MCUSYS) will feed through CIRQ and connect
+to GIC in MCUSYS. When CIRQ is enabled, it will record the edge-sensitive
+interrupts and generated a pulse signal to parent interrupt controller when
+flush command is executed. With CIRQ, MCUSYS can be completely turned off
+to improve the system power consumption without losing interrupts.
+
+Required properties:
+- compatible: should be: "mediatek,mt2701-cirq".
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
+- interrupt-parent: phandle of irq parent for cirq. The parent must
+  use the same interrupt-cells format as GIC.
+- reg: Physical base address of the cirq registers and length of memory
+  mapped region.
+- mediatek,ext-irq-start: Identifies external irq start number in different
+  SOCs.
+
+Example:
+	cirq: interrupt-controller at 10204000 {
+		compatible = "mediatek,mt2701-cirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&sysirq>;
+		reg = <0 0x10204000 0 0x4000>;
+		mediatek,ext-irq-start = <32>;
+	};
-- 
1.7.9.5
