From: stefan@agner.ch (Stefan Agner)
Date: Fri, 21 Apr 2017 18:23:36 -0700
Subject: [PATCH v2 3/5] mtd: gpmi: document current clock requirements
In-Reply-To: <20170422012338.4635-1-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
Message-ID: <20170422012338.4635-4-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock requirements are completely missing, add the clocks
currently required by the driver.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/mtd/gpmi-nand.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index d02acaff3c35..b289ef3c1b7e 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -4,7 +4,12 @@ The GPMI nand controller provides an interface to control the
 NAND flash chips.
 
 Required properties:
-  - compatible : should be "fsl,<chip>-gpmi-nand"
+  - compatible : should be "fsl,<chip>-gpmi-nand", chip can be:
+    * imx23
+    * imx28
+    * imx6q
+    * imx6sx
+    * imx7d
   - reg : should contain registers location and length for gpmi and bch.
   - reg-names: Should contain the reg names "gpmi-nand" and "bch"
   - interrupts : BCH interrupt number.
@@ -13,6 +18,13 @@ Required properties:
     and GPMI DMA channel ID.
     Refer to dma.txt and fsl-mxs-dma.txt for details.
   - dma-names: Must be "rx-tx".
+  - clocks : clocks phandle and clock specifier corresponding to each clock
+    specified in clock-names.
+  - clock-names : The "gpmi_io" clock is always required. Which clocks are
+    exactly required depends on chip:
+    * imx23/imx28 : "gpmi_io"
+    * imx6q/sx : "gpmi_io", "gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch"
+    * imx7d : "gpmi_io", "gpmi_bch_apb"
 
 Optional properties:
   - nand-on-flash-bbt: boolean to enable on flash bbt option if not
-- 
2.12.2
