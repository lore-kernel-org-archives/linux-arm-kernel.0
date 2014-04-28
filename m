From: b32955@freescale.com (Huang Shijie)
Date: Mon, 28 Apr 2014 11:53:42 +0800
Subject: [PATCH v2 05/10] Documentation: fsl-quadspi: update the document
In-Reply-To: <1398657227-20721-1-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
Message-ID: <1398657227-20721-6-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch updates the document by adding more information to describe the
DT proporties used by the Freescale Quadspi driver and the childs nodes.

For the child node for SPI NOR flash, we add the required property
("spi-max-frequency"), and refer to spi-nor-flash.txt for the optional
properties.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/fsl-quadspi.txt        |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
index 823d134..7e1dbaf 100644
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
@@ -1,5 +1,11 @@
 * Freescale Quad Serial Peripheral Interface(QuadSPI)
 
+The QuadSPI controller acts as the SPI master. It is described with a node
+for the controller and a set of child nodes for each SPI NOR flash.
+
+Part I - The DT node for the controller:
+------------------------------
+
 Required properties:
   - compatible : Should be "fsl,vf610-qspi"
   - reg : the first contains the register location and length,
@@ -18,6 +24,16 @@ Optional properties:
 			      bus, you should enable this property.
 			      (Please check the board's schematic.)
 
+Part II - The DT nodes for each SPI NOR flash
+------------------------------
+Required properties:
+- spi-max-frequency : Maximum frequency of the SPI bus the chip can operate at
+
+Optional properties:
+  Please refer to the Documentation/devicetree/bindings/mtd/spi-nor-flash.txt
+  If you set the "spi-nor,ddr-quad-read-dummy", it means you enable the DDR
+  quad read feature for the driver.
+
 Example:
 
 qspi0: quadspi at 40044000 {
-- 
1.7.2.rc3
