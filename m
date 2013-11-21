From: lho@apm.com (Loc Ho)
Date: Wed, 20 Nov 2013 23:11:36 -0700
Subject: [PATCH v4 2/4] Documentation:: Add documentation for APM X-Gene SoC
 SATA host controller DTS binding
In-Reply-To: <1385014298-15700-2-git-send-email-lho@apm.com>
References: <1385014298-15700-1-git-send-email-lho@apm.com>
 <1385014298-15700-2-git-send-email-lho@apm.com>
Message-ID: <1385014298-15700-3-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation:: Add documentation for APM X-Gene SoC SATA host controller DTS binding

Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
 .../devicetree/bindings/ata/apm-xgene.txt          |   56 ++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/apm-xgene.txt

diff --git a/Documentation/devicetree/bindings/ata/apm-xgene.txt b/Documentation/devicetree/bindings/ata/apm-xgene.txt
new file mode 100644
index 0000000..ec470b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/apm-xgene.txt
@@ -0,0 +1,56 @@
+* APM X-Gene 6.0 Gb/s SATA host controller nodes
+
+SATA host controller nodes are defined to describe on-chip Serial ATA
+controllers. Each SATA controller (pair of ports) have its own node.
+
+Required properties:
+- compatible		: Shall be "apm,xgene-ahci"
+- reg			: First memory resource shall be the AHCI memory
+			  resource.
+			  Second memory resource shall be the host controller
+			  memory resource.
+- interrupt-parent	: Interrupt controller
+- interrupts		: Interrupt mapping for SATA host controller IRQ
+- clocks		: Reference to the clock entry
+- phys			: PHY reference
+- phy-names		: Name of the PHY reference. The name should be
+			  formed by "sataphy" plus lower case hex for the
+			  lower 32-bit PHY CSR address (2nd memory resource)
+
+Optional properties:
+- status		: Shall be "ok" if enabled or "na" if disabled.
+			  Default is "ok".
+
+Example:
+		sata0: sata at 1a000000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a000000 0x0 0x100000>,
+			      <0x0 0x1f210000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x86 0x4>;
+			status = "disabled";
+			phys = <&sataphy0>;
+			phy-names = "sataphy1f210000";
+		};
+
+		sata1: sata at 1a400000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a400000 0x0 0x100000>,
+			      <0x0 0x1f220000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x87 0x4>;
+			status = "ok";
+			phys = <&sataphy1>;
+			phy-names = "sataphy1f220000";
+		};
+
+		sata2: sata at 1a800000 {
+			compatible = "apm,xgene-ahci";
+			reg = <0x0 0x1a800000 0x0 0x100000>,
+			      <0x0 0x1f230000 0x0 0x10000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0x0 0x88 0x4>;
+			status = "ok";
+			phys = <&sataphy2>;
+			phy-names = "sataphy1f230000";
+		};
-- 
1.5.5
