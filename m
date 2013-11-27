From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Nov 2013 02:18:36 +0100
Subject: [PATCH 14/15] spi: sh-msiof: Enable driver compilation with
 COMPILE_TEST
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1385515117-23664-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps increasing build testing coverage.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index eb1f1ef..51ae940 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -407,7 +407,8 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	depends on HAVE_CLK
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
-- 
1.8.3.2
