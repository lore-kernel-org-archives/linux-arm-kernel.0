From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 24 Dec 2012 02:08:45 +0100
Subject: [PATCH] ARM: pxa/colibri: fix SD detect pin
Message-ID: <1356311326-3065-1-git-send-email-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a missing else the Colibri PXA270 erroneously fell through
getting the PXA320's detect pin assigned.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---
 arch/arm/mach-pxa/colibri-evalboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index 8404b24..9e7a4d3 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -46,7 +46,7 @@ static void __init colibri_mmc_init(void)
 	if (machine_is_colibri())	/* PXA270 Colibri */
 		colibri_mci_platform_data.gpio_card_detect =
 			GPIO0_COLIBRI_PXA270_SD_DETECT;
-	if (machine_is_colibri300())	/* PXA300 Colibri */
+	else if (machine_is_colibri300())	/* PXA300 Colibri */
 		colibri_mci_platform_data.gpio_card_detect =
 			GPIO13_COLIBRI_PXA300_SD_DETECT;
 	else				/* PXA320 Colibri */
-- 
1.7.9.5
