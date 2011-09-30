From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 30 Sep 2011 17:09:40 +0530
Subject: [PATCH 2/2] SPI: EXYNOS4: Enable the SPI driver for EXYNOS4
In-Reply-To: <1317382780-3083-1-git-send-email-padma.v@samsung.com>
References: <1317382780-3083-1-git-send-email-padma.v@samsung.com>
Message-ID: <1317382780-3083-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPI module on EXYNOS4 is similar to the earlier Samsung SoCs like
S3C64XX. Enable the existing SPI driver for use on EXYNOS4.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 52e2900..f3649f6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -300,7 +300,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (ARCH_S3C64XX || ARCH_S5P64X0)
+	depends on ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_EXYNOS4
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.4.4
