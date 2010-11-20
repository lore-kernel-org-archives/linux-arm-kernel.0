From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 20 Nov 2010 11:08:49 +0100
Subject: [PATCH 2/6] at91rm9200dk: fix warning: 'dk_mmc_data' defined but not
	used
In-Reply-To: <20101120095906.GD4216@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
Message-ID: <1290247733-17834-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/board-dk.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/board-dk.c b/arch/arm/mach-at91/board-dk.c
index e14f0e1..16dfd0c 100644
--- a/arch/arm/mach-at91/board-dk.c
+++ b/arch/arm/mach-at91/board-dk.c
@@ -91,10 +91,12 @@ static struct at91_cf_data __initdata dk_cf_data = {
 	// .vcc_pin	= ... always powered
 };
 
+#ifndef CONFIG_MTD_AT91_DATAFLASH_CARD
 static struct at91_mmc_data __initdata dk_mmc_data = {
 	.slot_b		= 0,
 	.wire4		= 1,
 };
+#endif
 
 static struct spi_board_info dk_spi_devices[] = {
 	{	/* DataFlash chip */
-- 
1.7.1
