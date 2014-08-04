From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 4 Aug 2014 17:39:06 +0800
Subject: [PATCHv2 4/6] dt-bindings: arm: add Freescale LS1021A SoC device tree
 binding
In-Reply-To: <1407145148-29217-1-git-send-email-jingchang.lu@freescale.com>
References: <1407145148-29217-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1407145148-29217-5-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index e935d7d..c962124 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -74,3 +74,40 @@ Required root node properties:
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
+SoC-specific device tree bindings for system configuration
+-------------------------------------------
+
+Required device node compatible properties:
+
+  - compatible = "fsl,ls1021a-scfg":
+	scfg is the supplemental configuration unit, provides SoC specific
+	configuration and status registers for the chip. There is no dedicate
+	driver for it, but for device whose configuration and status register
+	locates in this space should operate on it. Such as getting PEX port
+	status.
+
+  - compatible = "fsl,ls1021a-dcfg":
+	dcfg is the device configuration unit that provides general purpose
+	configuration and status for the device, there is no dedicate driver
+	for it, but for device whose configuration and status register locates
+	in this space should operate on it. Such as setting the secondary core
+	start address and release the secondary core from holdoff and startup.
+
+Example:
+	scfg: scfg at 1570000 {
+		compatible = "fsl,ls1021a-scfg";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+	};
+
+	dcfg: dcfg at 1ee0000 {
+		compatible = "fsl,ls1021a-dcfg";
+		reg = <0x0 0x1ee0000 0x0 0x10000>;
+	};
-- 
1.8.0
