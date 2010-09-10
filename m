From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 Sep 2010 14:42:25 +0200
Subject: [PATCH] AT91: at91sam9261ek: remove C99 comments but keep information
In-Reply-To: <4C8A15AB.4030209@atmel.com>
References: <4C8A15AB.4030209@atmel.com>
Message-ID: <1284122545-14715-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-sam9261ek.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index 19d4d2c..65eb094 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -351,16 +351,14 @@ static struct spi_board_info ek_spi_devices[] = {
 };
 
 #else /* CONFIG_SPI_ATMEL_* */
+/* spi0 and mmc/sd share the same PIO pins: cannot be used at the same time */
 
 /*
  * MCI (SD/MMC)
- * spi0 and mmc/sd share the same PIO pins: cannot be used at the same time
+ * det_pin, wp_pin and vcc_pin are not connected
  */
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.wire4		= 1,
-//	.det_pin	= ... not connected
-//	.wp_pin		= ... not connected
-//	.vcc_pin	= ... not connected
 };
 
 #endif /* CONFIG_SPI_ATMEL_* */
-- 
1.5.6.5
