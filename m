From: stefan@agner.ch (Stefan Agner)
Date: Sun, 14 Dec 2014 23:09:57 +0100
Subject: [PATCH v2 2/3] irqchip: vf610-mscm: dt-bindings: add MSCM bindings
In-Reply-To: <1418594998-2361-1-git-send-email-stefan@agner.ch>
References: <1418594998-2361-1-git-send-email-stefan@agner.ch>
Message-ID: <1418594998-2361-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for Miscellaneous System Control Module
found in Freescale Vybrid SoC's.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../bindings/arm/freescale/fsl,vf610-mscm.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
new file mode 100644
index 0000000..1428a53
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
@@ -0,0 +1,21 @@
+Freescale Vybrid Miscellaneous System Control Module
+
+The MSCM IP contains Access Control and TrustZone Security hardware,
+CPU Configuration registers and Interrupt Router control.
+
+Required properties:
+- compatible : "fsl,vf610-mscm"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Use the same format as specified by the parent
+  interrupt controller, e.g.
+  Documentation/devicetree/bindings/arm/gic.txt
+- reg : the register range of the MSCM module
+
+Example:
+	mscm: mscm at 40001000 {
+		compatible = "fsl,vf610-mscm";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&intc>;
+		reg = <0x40001000 0x1000>;
+	}
-- 
2.1.3
