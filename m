From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  2 Apr 2012 17:30:17 +0100
Subject: [PATCH] ARM: DT: Add binding for GIC virtualization extentions (VGIC)
Message-ID: <1333384217-13441-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv2 can have virtualization extension support, consisting
of an additional set of registers and interrupts. Add the necessary
binding to the GIC DT documentation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/devicetree/bindings/arm/gic.txt |   29 +++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index 9b4b82a..fb1b5ab 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -57,3 +57,32 @@ Example:
 		      <0xfff10100 0x100>;
 	};
 
+
+* GIC virtualization extensions (VGIC)
+
+For ARM cores that support the virtualization extensions, an
+additional node describes the VGIC hardware block. Only exists if the
+GIC is the primary interrupt controller.
+
+Required properties:
+- compatible : should be one of:
+	"arm,cortex-a15-vgic"
+	"arm,cortex-a7-vgic"
+	"arm,vgic"
+
+- reg : Specifies base physical address and size of the VGIC
+  registers. The first region is the GIC virtual interface control
+  register base and size.  the 2nd region is the GIC virtual cpu
+  interface register base and size.
+
+- interrupts : VGIC maintainance interrupt. Must be relative to the
+  primary GIC.
+
+Example:
+
+	vgic at 2c004000 {
+		compatible = "arm,cortex-a15-vgic", "arm,vgic";
+		reg = <0x2c004000 0x2000>,
+		      <0x2c006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
-- 
1.7.7.1
