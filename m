From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 23:46:36 +0900
Subject: [PATCH v2 2/7] bindings: spi-samsung: document the clocks and the
 clock-name property
In-Reply-To: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467989201-14661-3-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two properties were not documented but used in the spi
dts. Add the related documentation.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 57d5539..2b7167e 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -24,6 +24,14 @@ Required SoC Specific Properties:
 - dma-names: Names for the dma channels. There must be at least one channel
   named "tx" for transmit and named "rx" for receive.
 
+- clocks: specifies the clock IDs provided to the SPI controller; they are
+  required for interacting with the controller itself, for synchronizing the bus
+  and as I/O clock (the latter is required by exynos5433 and exynos7).
+
+- clock-names: string names of the clocks in the 'clocks' property; the names
+  mut be "spi", "spi_busclkN" and "spi_ioclk", where N is determined by
+  "samsung,spi-src-clk".
+
 Required Board Specific Properties:
 
 - #address-cells: should be 1.
-- 
2.8.1
