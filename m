From: dp@opensource.wolfsonmicro.com (Dimitris Papastamos)
Date: Fri,  2 Nov 2012 10:38:53 +0000
Subject: [PATCH] ARM: S3C64XX: Fix up IRQ mapping for balblair on Cragganmore
Message-ID: <1351852733-3346-1-git-send-email-dp@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are using S3C_EINT(4) instead of S3C_EINT(5).

Change-Id: Ia197069ddc736813f2711c763469eaf655ea58ac
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 4744c42..c6d8dba 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -60,7 +60,7 @@ static struct spi_board_info balblair_devs[] = {
 		.bus_num	= 0,
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,
-		.irq		= S3C_EINT(5),
+		.irq		= S3C_EINT(4),
 		.controller_data = &wm0010_spi_csinfo,
 		.platform_data = &wm0010_pdata,
 	},
-- 
1.8.0
