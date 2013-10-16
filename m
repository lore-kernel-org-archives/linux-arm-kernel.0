From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 21:10:52 +0200
Subject: [PATCH v2 1/8] spi: s3c64xx: Do not require legacy DMA API in case of
 S3C64XX
In-Reply-To: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1381950659-12703-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support for amba-pl08x driver, on S3C64xx the generic DMA engine
API can be used instead of the private s3c-dma interface.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index eb1f1ef..760d7b6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -395,7 +395,7 @@ config SPI_S3C24XX_FIQ
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on PLAT_SAMSUNG
-	select S3C64XX_DMA if ARCH_S3C64XX
+	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
-- 
1.8.3.2
