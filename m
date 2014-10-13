From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 13 Oct 2014 17:36:01 +0800
Subject: [PATCHv5 4/6] dt-bindings: arm: add Freescale LS1021A SoC device tree
 binding
In-Reply-To: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1413192963-11153-5-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index e935d7d..4e8b7df 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -74,3 +74,41 @@ Required root node properties:
 i.MX6q generic board
 Required root node properties:
     - compatible = "fsl,imx6q";
+
+
+Freescale LS1021A Platform Device Tree Bindings
+------------------------------------------------
+
+Required root node compatible properties:
+  - compatible = "fsl,ls1021a";
+
+Freescale LS1021A SoC-specific Device Tree Bindings
+-------------------------------------------
+
+Freescale SCFG
+  SCFG is the supplemental configuration unit, that provides SoC specific
+configuration and status registers for the chip. Such as getting PEX port
+status.
+  Required properties:
+  - compatible: should be "fsl,ls1021a-scfg"
+  - reg: should contain base address and length of SCFG memory-mapped registers
+
+Example:
+	scfg: scfg at 1570000 {
+		compatible = "fsl,ls1021a-scfg";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+	};
+
+Freescale DCFG
+  DCFG is the device configuration unit, that provides general purpose
+configuration and status for the device. Such as setting the secondary
+core start address and release the secondary core from holdoff and startup.
+  Required properties:
+  - compatible: should be "fsl,ls1021a-dcfg"
+  - reg : should contain base address and length of DCFG memory-mapped registers
+
+Example:
+	dcfg: dcfg at 1ee0000 {
+		compatible = "fsl,ls1021a-dcfg";
+		reg = <0x0 0x1ee0000 0x0 0x10000>;
+	};
-- 
1.8.0
