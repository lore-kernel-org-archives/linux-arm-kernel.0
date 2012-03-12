From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Mar 2012 20:03:36 +0100
Subject: [PATCH 6/6] spi/s3c64xx: Allow usage for ARCH_S3C24XX
In-Reply-To: <201203121959.32966.heiko@sntech.de>
References: <201203121959.32966.heiko@sntech.de>
Message-ID: <201203122003.36553.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer SoCs from the S3C24XX line, namely S3C2416/2443/2450 contain
hsspi-controllers compatible with the s3c64xx type.

The previous patches enabled platform support for it, so make the
driver also usable for the S3C24xx architecture.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 004e6d1..e981fe6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -305,7 +305,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
+	depends on (ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.2.3
