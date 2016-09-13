From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Tue, 13 Sep 2016 16:09:55 +0800
Subject: [PATCH 02/10][v3] dt-bindings: fsl: updates bindings for some
 SoC-specific devices
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473754203-22970-3-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

SCFG and DCFG are SoC-specific devices can be found on SoCs like LS1021A,
LS1043A and LS1046A, this patch updates bindings for SCFG and DCFG to
reflect more SoCs.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
changes in V3:
1. added supported <chip>s.

change in V2:
1. new patch.

 Documentation/devicetree/bindings/arm/fsl.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 2efbc09..a81277f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -97,7 +97,7 @@ Freescale LS1021A Platform Device Tree Bindings
 Required root node compatible properties:
   - compatible = "fsl,ls1021a";
 
-Freescale LS1021A SoC-specific Device Tree Bindings
+Freescale SoC-specific Device Tree Bindings
 -------------------------------------------
 
 Freescale SCFG
@@ -105,7 +105,11 @@ Freescale SCFG
 configuration and status registers for the chip. Such as getting PEX port
 status.
   Required properties:
-  - compatible: should be "fsl,ls1021a-scfg"
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-scfg",
+	The following <chip>s are known to be supported:
+	ls1021a, ls1043a, ls1046a, ls2080a.
+
   - reg: should contain base address and length of SCFG memory-mapped registers
 
 Example:
@@ -119,7 +123,11 @@ Freescale DCFG
 configuration and status for the device. Such as setting the secondary
 core start address and release the secondary core from holdoff and startup.
   Required properties:
-  - compatible: should be "fsl,ls1021a-dcfg"
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-dcfg",
+	The following <chip>s are known to be supported:
+	ls1021a, ls1043a, ls1046a, ls2080a.
+
   - reg : should contain base address and length of DCFG memory-mapped registers
 
 Example:
-- 
2.1.0.27.g96db324
