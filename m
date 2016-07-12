From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 12 Jul 2016 19:02:11 +0900
Subject: [PATCH v3 2/7] bindings: spi-samsung: document the clocks and the
 clock-name property
In-Reply-To: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
References: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1468317736-18841-3-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two properties were not documented but used in the spi
dts. Add the related documentation.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 57d5539..f45c6eb 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -24,6 +24,15 @@ Required SoC Specific Properties:
 - dma-names: Names for the dma channels. There must be at least one channel
   named "tx" for transmit and named "rx" for receive.
 
+- clocks: specifies the clock IDs provided to the SPI controller; they are
+  required for interacting with the controller itself, for synchronizing the bus
+  and as I/O clock (the latter is required by exynos5433 and exynos7).
+
+- clock-names: string names of the clocks in the 'clocks' property; for all the
+  the devices the names must be "spi", "spi_busclkN" (where N is determined by
+  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
+  "spi_ioclk" for the I/O clock.
+
 Required Board Specific Properties:
 
 - #address-cells: should be 1.
-- 
2.8.1
