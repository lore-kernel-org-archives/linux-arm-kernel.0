From: vigneshr@ti.com (Vignesh R)
Date: Sun, 24 Sep 2017 16:29:20 +0530
Subject: [PATCH v3 1/5] mtd: spi-nor: cadence-quadspi: Add TI 66AK2G SoC
 specific compatible
In-Reply-To: <20170924105924.23923-1-vigneshr@ti.com>
References: <20170924105924.23923-1-vigneshr@ti.com>
Message-ID: <20170924105924.23923-2-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update binding documentation to add a new compatible for TI 66AK2G SoC,
to handle TI SoC specific quirks in the driver.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index f248056da24c..7dbe3bd9ac56 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -1,7 +1,9 @@
 * Cadence Quad SPI controller
 
 Required properties:
-- compatible : Should be "cdns,qspi-nor".
+- compatible : should be one of the following:
+	Generic default - "cdns,qspi-nor".
+	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
 - reg : Contains two entries, each of which is a tuple consisting of a
 	physical address and length. The first entry is the address and
 	length of the controller register set. The second entry is the
-- 
2.14.1
