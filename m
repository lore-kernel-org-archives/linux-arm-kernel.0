From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 23:37:52 +0100
Subject: [PATCH v2 17/19] spi: sh_hspi: Enable the driver on all ARM platforms
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383086274-11049-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 70f5aa3..43e0a4a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -426,7 +426,7 @@ config SPI_SH_SCI
 
 config SPI_SH_HSPI
 	tristate "SuperH HSPI controller"
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARM || COMPILE_TEST
 	help
 	  SPI driver for SuperH HSPI blocks.
 
-- 
1.8.1.5
