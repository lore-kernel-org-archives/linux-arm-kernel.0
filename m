From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 20:31:37 -0400
Subject: [PATCH] spi: davinci: Update configs to make it selectable on Keystone
Message-ID: <1374712297-32187-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone2 SOCs share the SPI IP block with DaVinci based SOCs. Update
the config bits so that its usable on Keystone2 based SOCs.

Cc: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 89cbbab..3858d66 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -151,7 +151,7 @@ config SPI_COLDFIRE_QSPI
 
 config SPI_DAVINCI
 	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	select SPI_BITBANG
 	select TI_EDMA
 	help
-- 
1.7.9.5
