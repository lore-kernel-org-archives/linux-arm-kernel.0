From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 12 Dec 2012 12:54:47 +0100
Subject: [PATCH 2/4 v2] spi: Add SH Mobile series as dependency to MSIOF
 controller
In-Reply-To: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1355313289-29769-2-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

The MSIOF hardware block is used in the SH Mobile series as well, so we
add it here.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: no changes

 drivers/spi/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
1.7.9.5
