From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 20 Nov 2010 11:08:50 +0100
Subject: [PATCH 3/6] at91rm9200ek: fix warning: 'ek_mmc_data' defined but not
	used
In-Reply-To: <20101120095906.GD4216@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
Message-ID: <1290247733-17834-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/board-ek.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-ek.c b/arch/arm/mach-at91/board-ek.c
index 56e92c4..6203cdf 100644
--- a/arch/arm/mach-at91/board-ek.c
+++ b/arch/arm/mach-at91/board-ek.c
@@ -84,12 +84,14 @@ static struct at91_udc_data __initdata ek_udc_data = {
 	.pullup_pin	= AT91_PIN_PD5,
 };
 
+#ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
 static struct at91_mmc_data __initdata ek_mmc_data = {
 	.det_pin	= AT91_PIN_PB27,
 	.slot_b		= 0,
 	.wire4		= 1,
 	.wp_pin		= AT91_PIN_PA17,
 };
+#endif
 
 static struct spi_board_info ek_spi_devices[] = {
 	{	/* DataFlash chip */
-- 
1.7.1
