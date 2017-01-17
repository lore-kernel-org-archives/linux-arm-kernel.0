From: Minghuan.Lian@nxp.com (Minghuan Lian)
Date: Tue, 17 Jan 2017 17:32:35 +0800
Subject: [PATCH v3 1/9] irqchip/ls-scfg-msi: fix typo of MSI compatible strings
In-Reply-To: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1484645563-29877-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <1484645563-29877-2-git-send-email-Minghuan.Lian@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is to fix typo of the Layerscape SCFG MSI dts compatible
strings. "1" is replaced by "l".

Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v3-v1:
- None

 .../devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt    | 6 +++---
 drivers/irqchip/irq-ls-scfg-msi.c                                   | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
index 9e38949..2755cd1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
@@ -4,8 +4,8 @@ Required properties:
 
 - compatible: should be "fsl,<soc-name>-msi" to identify
 	      Layerscape PCIe MSI controller block such as:
-              "fsl,1s1021a-msi"
-              "fsl,1s1043a-msi"
+              "fsl,ls1021a-msi"
+              "fsl,ls1043a-msi"
 - msi-controller: indicates that this is a PCIe MSI controller node
 - reg: physical base address of the controller and length of memory mapped.
 - interrupts: an interrupt to the parent interrupt controller.
@@ -23,7 +23,7 @@ MSI controller node
 Examples:
 
 	msi1: msi-controller at 1571000 {
-		compatible = "fsl,1s1043a-msi";
+		compatible = "fsl,ls1043a-msi";
 		reg = <0x0 0x1571000 0x0 0x8>,
 		msi-controller;
 		interrupts = <0 116 0x4>;
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 02cca74c..cef67cc 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -219,8 +219,10 @@ static int ls_scfg_msi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ls_scfg_msi_id[] = {
-	{ .compatible = "fsl,1s1021a-msi", },
-	{ .compatible = "fsl,1s1043a-msi", },
+	{ .compatible = "fsl,1s1021a-msi", }, /* a typo */
+	{ .compatible = "fsl,1s1043a-msi", }, /* a typo */
+	{ .compatible = "fsl,ls1021a-msi", },
+	{ .compatible = "fsl,ls1043a-msi", },
 	{},
 };
 
-- 
1.9.1
