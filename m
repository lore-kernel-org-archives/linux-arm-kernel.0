From: hechtb@gmail.com (Bastian Hecht)
Date: Wed,  7 Nov 2012 12:40:05 +0100
Subject: [PATCH 2/4] spi: Add SH Mobile series as dependency to MSIOF
 controller
In-Reply-To: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
Message-ID: <1352288407-20594-3-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSIOF hardware block is used in the SH Mobile series as well, so we
add it here.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/spi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1acae35..d0c0ae6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -341,10 +341,10 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on SUPERH && HAVE_CLK
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select SPI_BITBANG
 	help
-	  SPI driver for SuperH MSIOF blocks.
+	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
 config SPI_SH
 	tristate "SuperH SPI controller"
-- 
1.7.5.4
