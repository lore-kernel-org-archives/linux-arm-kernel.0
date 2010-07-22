From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 22 Jul 2010 14:34:58 +0800
Subject: [PATCH] ARM/nuc900: patch for modifying spi flash configuration
Message-ID: <AANLkTikJruYLIo3By6Wq1evr7J6giz4-73XcPKOFFgKZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to modify spi flash configuration,
the previous one can make spi driver work failed.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/dev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index 7ae5438..7a1fa6a 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -209,7 +209,7 @@ static struct nuc900_spi_info nuc900_spiflash_data = {
 	.divider	= 24,
 	.sleep		= 0,
 	.txnum		= 0,
-	.txbitlen	= 1,
+	.txbitlen	= 8,
 	.bus_num	= 0,
 };

@@ -258,7 +258,7 @@ static struct spi_board_info
nuc900_spi_board_info[] __initdata = {
 		.modalias = "m25p80",
 		.max_speed_hz = 20000000,
 		.bus_num = 0,
-		.chip_select = 1,
+		.chip_select = 0,
 		.platform_data = &nuc900_spi_flash_data,
 		.mode = SPI_MODE_0,
 	},
-- 
1.6.3.3

-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
