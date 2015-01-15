From: stefan@agner.ch (Stefan Agner)
Date: Thu, 15 Jan 2015 09:04:05 +0100
Subject: [PATCH RESEND v3 2/3] irqchip: vf610-mscm: dt-bindings: add MSCM
 bindings
In-Reply-To: <1421309046-22452-1-git-send-email-stefan@agner.ch>
References: <1421309046-22452-1-git-send-email-stefan@agner.ch>
Message-ID: <1421309046-22452-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for Miscellaneous System Control Module
found in Freescale Vybrid SoC's.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../bindings/arm/freescale/fsl,vf610-mscm.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
new file mode 100644
index 0000000..e051b88
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
@@ -0,0 +1,19 @@
+Freescale Vybrid Miscellaneous System Control Module
+
+The MSCM IP contains Access Control and TrustZone Security hardware,
+CPU Configuration registers and Interrupt Router control.
+
+Required properties:
+- compatible : "fsl,vf610-mscm", "syscon"
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Two cells, interrupt number and flags (IRQ type)
+- reg : the register range of the MSCM module
+
+Example:
+	mscm: mscm at 40001000 {
+		compatible = "fsl,vf610-mscm", "syscon";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&intc>;
+		reg = <0x40001000 0x1000>;
+	}
-- 
2.2.1
