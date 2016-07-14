From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jul 2016 17:32:58 +0100
Subject: Applied "spi: s3c64xx: document the clocks and the clock-name
 property" to the spi tree
In-Reply-To: <1468204581-16873-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <E1bNjZK-0001oy-Pz@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: s3c64xx: document the clocks and the clock-name property

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1ada32ede94fc91ff0f3236fcc70ae74dd0c2cb0 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@samsung.com>
Date: Tue, 12 Jul 2016 19:02:11 +0900
Subject: [PATCH] spi: s3c64xx: document the clocks and the clock-name property

These two properties were not documented but used in the spi
dts. Add the related documentation.

Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reviewed-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index ab4f0a46e859..49028a4f5df1 100644
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
