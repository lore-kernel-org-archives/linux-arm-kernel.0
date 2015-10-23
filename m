From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Sat, 24 Oct 2015 01:01:53 +0530
Subject: [PATCH v4 04/12] Documentation/dts: Move FSL board-specific bindings
 out of /powerpc
In-Reply-To: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1445628721-10483-5-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the same board components can be used across ARM and PPC board families,
this patch moves the FSL board-specific bindings out of bindings/powerpci.

While at it, this patch also adds the bindings for QIXIS FPGA controller
found on FSL LS2080A boards. These boards have an on-board FPGA/CPLD
connected to the IFC controller.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
---
 .../{powerpc/fsl/board.txt => board/fsl-board.txt} |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/board.txt => board/fsl-board.txt} (90%)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/board/fsl-board.txt
similarity index 90%
rename from Documentation/devicetree/bindings/powerpc/fsl/board.txt
rename to Documentation/devicetree/bindings/board/fsl-board.txt
index cff38bd..fb7b03e 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
+++ b/Documentation/devicetree/bindings/board/fsl-board.txt
@@ -21,11 +21,14 @@ Example:
 
 This is the memory-mapped registers for on board FPGA.
 
-Required properities:
+Required properties:
 - compatible: should be a board-specific string followed by a string
   indicating the type of FPGA.  Example:
-	"fsl,<board>-fpga", "fsl,fpga-pixis"
+	"fsl,<board>-fpga", "fsl,fpga-pixis", or
+	"fsl,<board>-fpga", "fsl,fpga-qixis"
 - reg: should contain the address and the length of the FPGA register set.
+
+Optional properties:
 - interrupt-parent: should specify phandle for the interrupt controller.
 - interrupts: should specify event (wakeup) IRQ.
 
@@ -38,6 +41,13 @@ Example (P1022DS):
 		 interrupts = <8 8 0 0>;
 	 };
 
+Example (LS2080A-RDB):
+
+        cpld at 3,0 {
+                compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
+                reg = <0x3 0 0x10000>;
+        };
+
 * Freescale BCSR GPIO banks
 
 Some BCSR registers act as simple GPIO controllers, each such
-- 
1.7.9.5
