From: b32955@freescale.com (Huang Shijie)
Date: Wed, 23 Apr 2014 18:16:51 +0800
Subject: [PATCH v1 3/7] Documentation: mtd: add a new document for SPI NOR
 flash
In-Reply-To: <a>
References: <a>
Message-ID: <1398248215-26768-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a DT property to store the dummy cycles for DDR Quad read.
This is a common feature for the SPI NOR flash, such as Spansion and Micron
chips.

Add this file to describe this specific SPI NOR flash features which will
be referred by the SPI NOR flash drivers.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/mtd/spi-nor-flash.txt      |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nor-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt b/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt
new file mode 100644
index 0000000..aba4d54
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nor-flash.txt
@@ -0,0 +1,7 @@
+This file defines some DT properties for specific SPI NOR flash features.
+The SPI NOR controller drivers may refer to this file, such as fsl-quadspi.txt
+
+Optional properties:
+  - spi-nor,ddr-quad-read-dummy: The dummy cycles used by the DDR Quad read.
+                                 Please refer to the chip's datasheet. This
+                                 property can be 4 or 6 which is less then 8.
-- 
1.7.2.rc3
