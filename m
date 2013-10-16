From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 21:10:58 +0200
Subject: [PATCH v2 7/8] spi: s3c64xx: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1381950659-12703-8-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy S3C64xx DMA driver has been removed, DMA support on
S3C64xx is provided only by the generic PL08x driver.

This patch modifies the Kconfig entry of spi-s3c64xx driver, which
relies on availability of DMA, to always select the S3C64XX_PL080
symbol.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 760d7b6..e2dd2fb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -395,7 +395,7 @@ config SPI_S3C24XX_FIQ
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on PLAT_SAMSUNG
-	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
+	select S3C64XX_PL080 if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
-- 
1.8.3.2
