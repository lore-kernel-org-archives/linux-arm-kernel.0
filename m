From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Fri, 4 Sep 2015 12:27:45 +0530
Subject: [PATCH v2 03/10] Documentation/dts: Add bindings for QIXIS FPGA
 controller found on FSL boards
In-Reply-To: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1441349872-4560-4-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds bindings for QIXIS FPGA controller found on FSL boards.

Some Freescale boards like LS2080AQDS/LS2080ARDB have an on-board FPGA/CPLD
connected to the IFC controller. The bindings specified in this patch
cater to those on-board FPGA/CPLD controllers.

Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/arm/fsl,board.txt          |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl,board.txt

diff --git a/Documentation/devicetree/bindings/arm/fsl,board.txt b/Documentation/devicetree/bindings/arm/fsl,board.txt
new file mode 100644
index 0000000..756b730
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl,board.txt
@@ -0,0 +1,31 @@
+Freescale Reference Board Bindings
+----------------------------------
+
+This document describes device tree bindings for various devices that
+exist on some Freescale reference boards.
+
+* Freescale on-board FPGA connected to IFC controller
+
+Some Freescale boards like LS2080AQDS/LS2080ARDB have an on-board FPGA/CPLD
+connected to the IFC controller.
+
+Required properties:
+- compatible: Should be a board-specific string followed by a string
+  indicating the type of FPGA.  Example:
+       "fsl,ls2080a-qds-qixis", "fsl,fpga-qixis"
+       "fsl,ls2080a-rdb-qixis", "fsl,fpga-qixis"
+- reg: The register set for the device
+
+Example:
+       &ifc {
+               status = "okay";
+               #address-cells = <2>;
+               #size-cells <1>;
+               ranges = <0x3 0x0 0x5 0x20000000 0x00010000>;
+
+               cpld at 3,0 {
+                       compatible = "fsl,ls2080a-qds-qixis", "fsl,fpga-qixis";
+                       reg = <0x3 0 0x10000>;
+               };
+       };
+
-- 
1.7.9.5
