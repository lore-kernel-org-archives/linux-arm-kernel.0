From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  5 Jul 2011 14:18:02 -0600
Subject: [PATCH] spi/tegra: Use engineering names in DT compatible property
Message-ID: <1309897082-22695-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Engineering names are more stable than marketing names. Hence, use them
for Device Tree compatible properties instead.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Grant, this is against devicetree/arm, and also makes sense for
devicetree/test.

 .../devicetree/bindings/spi/spi_nvidia.txt         |    2 +-
 drivers/spi/spi_tegra.c                            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi_nvidia.txt b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
index bde450b..6b9e518 100644
--- a/Documentation/devicetree/bindings/spi/spi_nvidia.txt
+++ b/Documentation/devicetree/bindings/spi/spi_nvidia.txt
@@ -1,5 +1,5 @@
 NVIDIA Tegra 2 SPI device
 
 Required properties:
-- compatible : should be "nvidia,tegra250-spi".
+- compatible : should be "nvidia,tegra20-spi".
 - gpios : should specify GPIOs used for chipselect.
diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
index 1e7de98..b0e3586 100644
--- a/drivers/spi/spi_tegra.c
+++ b/drivers/spi/spi_tegra.c
@@ -598,7 +598,7 @@ MODULE_ALIAS("platform:spi_tegra");
 
 #ifdef CONFIG_OF
 static struct of_device_id spi_tegra_of_match_table[] __devinitdata = {
-	{ .compatible = "nvidia,tegra250-spi", },
+	{ .compatible = "nvidia,tegra20-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, spi_tegra_of_match_table);
-- 
1.7.0.4
