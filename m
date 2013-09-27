From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 Sep 2013 19:42:35 -0400
Subject: [PATCH 3/4] spi: davinci: Allow SPI to be build without EDMA support
In-Reply-To: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DaVinci SPI IP works without EDMA support and thats how it has
been used on Keystone SOCs currently. Hence keep the EDMA select
limited to ARCH_DAVINCI so that Keystone SOCs can use the driver.

Keystone SOC do support EDMA IP as well but the support has
not been added and tested so far.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Mark,
If you are ok with this trivial change, I will need your ack to carry the patch
via arm-soc tree. Without this patch, enabling SPI throws unmet dependency
warnings and last patch in the series enables the SPI support.

 drivers/spi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b9c53cc..514d883 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -159,7 +159,7 @@ config SPI_DAVINCI
 	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
 	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	select SPI_BITBANG
-	select TI_EDMA
+	select TI_EDMA if ARCH_DAVINCI
 	help
 	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
 
-- 
1.7.9.5
