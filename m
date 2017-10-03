From: vigneshr@ti.com (Vignesh R)
Date: Tue, 3 Oct 2017 10:49:22 +0530
Subject: [PATCH v4 3/6] mtd: spi-nor: cadence-quadspi: Add new binding to
 enable loop-back circuit
In-Reply-To: <20171003051925.8821-1-vigneshr@ti.com>
References: <20171003051925.8821-1-vigneshr@ti.com>
Message-ID: <20171003051925.8821-4-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence QSPI IP has a adapted loop-back circuit which can be enabled by
setting BYPASS field to 0 in READCAPTURE register. It enables use of
QSPI return clock to latch the data rather than the internal QSPI
reference clock. For high speed operations, adapted loop-back circuit
using QSPI return clock helps to increase data valid window.

Add DT parameter cdns,rclk-en to help enable adapted loop-back circuit
for boards which do have QSPI return clock provided. Update binding
documentation for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index 7dbe3bd9ac56..bb2075df9b38 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -16,6 +16,9 @@ Required properties:
 
 Optional properties:
 - cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
+- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
+  the read data rather than the QSPI clock. Make sure that QSPI return
+  clock is populated on the board before using this property.
 
 Optional subnodes:
 Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
-- 
2.14.1
