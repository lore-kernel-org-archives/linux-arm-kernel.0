From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 25 Nov 2014 16:04:22 +0800
Subject: [PATCH v8 4/4] dt-bindings: add bindings for mediatek sysirq
In-Reply-To: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1416902662-19281-5-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for Mediatek SoC SYSIRQ.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,sysirq.txt      | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
new file mode 100644
index 0000000..d680b07
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
@@ -0,0 +1,28 @@
+Mediatek 65xx/81xx sysirq
+
+Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
+interrupt.
+
+Required properties:
+- compatible: should be one of:
+	"mediatek,mt8135-sysirq"
+	"mediatek,mt8127-sysirq"
+	"mediatek,mt6589-sysirq"
+	"mediatek,mt6582-sysirq"
+	"mediatek,mt6577-sysirq"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Use the same format as specified by GIC in
+  Documentation/devicetree/bindings/arm/gic.txt
+- interrupt-parent: phandle of irq parent for sysirq. The parent must
+  use the same interrupt-cells format as GIC.
+- reg: Physical base address of the intpol registers and length of memory
+  mapped region.
+
+Example:
+	sysirq: interrupt-controller at 10200100 {
+		compatible = "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10200100 0 0x1c>;
+	};
-- 
1.8.1.1.dirty
