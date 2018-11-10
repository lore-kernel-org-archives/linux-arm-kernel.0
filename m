From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:13:00 +0000
Subject: [PATCH V5 2/6] dt-bindings: fsl: add imx7ulp pm related components
 bindings
In-Reply-To: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541862478-7839-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx7ulp pm related components bindings

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree at vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v2->v3:
 * no changes
v1->v2:
 * new patch
---
 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
new file mode 100644
index 0000000..75195be
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
@@ -0,0 +1,23 @@
+Freescale i.MX7ULP Power Management Components
+----------------------------------------------
+
+The Multi-System Mode Controller (MSMC) is responsible for sequencing
+the MCU into and out of all stop and run power modes. Specifically, it
+monitors events to trigger transitions between power modes while
+controlling the power, clocks, and memories of the MCU to achieve the
+power consumption and functionality of that mode.
+
+The WFI or WFE instruction is used to invoke a Sleep, Deep Sleep or
+Standby modes for either Cortex family. Run, Wait, and Stop are the
+common terms used for the primary operating modes of Kinetis
+microcontrollers.
+
+Required properties:
+- compatible:	Should be "fsl,imx7ulp-smc1".
+- reg:		Specifies base physical address and size of the register sets.
+
+Example:
+smc1: smc1 at 40410000 {
+	compatible = "fsl,imx7ulp-smc1";
+	reg = <0x40410000 0x1000>;
+};
-- 
2.7.4
