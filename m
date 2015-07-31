From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 18:45:54 +0200
Subject: [PATCH] mfd: atmel-hlcdc: Add support for new SoCs
Message-ID: <1438361154-10596-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible strings for the at91sam9x5, at91sam9n12, sama5d4 and
sama5d2 SoCs.
Update the documentation accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 4 ++++
 drivers/mfd/atmel-hlcdc.c                             | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
index f64de95a..ad5d904 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -2,7 +2,11 @@ Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
 
 Required properties:
  - compatible: value should be one of the following:
+   "atmel,at91sam9n12-hlcdc"
+   "atmel,at91sam9x5-hlcdc"
+   "atmel,sama5d2-hlcdc"
    "atmel,sama5d3-hlcdc"
+   "atmel,sama5d4-hlcdc"
  - reg: base address and size of the HLCDC device registers.
  - clock-names: the name of the 3 clocks requested by the HLCDC device.
    Should contain "periph_clk", "sys_clk" and "slow_clk".
diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index d1d6e8f..3fff6b5 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -141,7 +141,11 @@ static int atmel_hlcdc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id atmel_hlcdc_match[] = {
+	{ .compatible = "atmel,at91sam9n12-hlcdc" },
+	{ .compatible = "atmel,at91sam9x5-hlcdc" },
+	{ .compatible = "atmel,sama5d2-hlcdc" },
 	{ .compatible = "atmel,sama5d3-hlcdc" },
+	{ .compatible = "atmel,sama5d4-hlcdc" },
 	{ /* sentinel */ },
 };
 
-- 
1.9.1
