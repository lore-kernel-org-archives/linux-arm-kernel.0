From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 00:47:04 +0100
Subject: [PATCH 16/19] spi: sh_msiof: Enable the driver on all ARM platforms
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383004027-25036-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b9c53cc..a69b740 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -406,7 +406,7 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on (SUPERH || ARM) && HAVE_CLK
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
-- 
1.8.1.5
