From: vigneshr@ti.com (Vignesh R)
Date: Wed, 3 Oct 2018 22:26:02 +0530
Subject: [PATCH 2/3] dt-bindings: cadence-quadspi: Add new compatible for
 AM654 SoC
In-Reply-To: <20181003165603.2579-1-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
Message-ID: <20181003165603.2579-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM654 SoC has Cadence Octal SPI controller, which is similar to Cadence
QSPI controller but supports Octal IO(x8 data lines) and Double Data
Rate(DDR) mode. Add new compatible to support OSPI controller on TI's
AM654 SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index bb2075df9b38..4345c3a6f530 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : should be one of the following:
 	Generic default - "cdns,qspi-nor".
 	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
+	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
 - reg : Contains two entries, each of which is a tuple consisting of a
 	physical address and length. The first entry is the address and
 	length of the controller register set. The second entry is the
-- 
2.19.0
