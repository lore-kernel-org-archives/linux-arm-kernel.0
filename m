From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 9 Sep 2010 22:32:05 +0200
Subject: [PATCH] ux500: use _cansleep GPIO functions
Message-ID: <1284064325-14570-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the patch to MMCI this silences similar messages from
the platform code.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 9662d9d..33a65f8 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -93,9 +93,9 @@ static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
 				   unsigned char power_mode)
 {
 	if (power_mode == MMC_POWER_UP)
-		gpio_set_value(GPIO_SDMMC_EN, 1);
+		gpio_set_value_cansleep(GPIO_SDMMC_EN, 1);
 	else if (power_mode == MMC_POWER_OFF)
-		gpio_set_value(GPIO_SDMMC_EN, 0);
+		gpio_set_value_cansleep(GPIO_SDMMC_EN, 0);
 
 	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
 	       MCI_DATA2DIREN | MCI_DATA31DIREN;
-- 
1.6.3.3
