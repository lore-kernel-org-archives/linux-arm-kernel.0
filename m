From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 11 Aug 2013 19:59:29 +0200
Subject: [PATCH 17/18] spi: s3c64xx: Always select S3C64XX_PL080 when
 ARCH_S3C64XX is enabled
In-Reply-To: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1376243970-6489-18-git-send-email-tomasz.figa@gmail.com>
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
index 241a049..a13867e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -366,7 +366,7 @@ config SPI_S3C24XX_FIQ
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on (ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
-	select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080
+	select S3C64XX_PL080 if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
-- 
1.8.3.2
