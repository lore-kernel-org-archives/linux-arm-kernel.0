From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 15 Feb 2010 12:24:00 +0100
Subject: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
Message-ID: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This employs the frequency setting mechanism introduced to the
MMCI to specify that this system can actually be clocked at 24 MHz.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/mmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/mmc.c b/arch/arm/mach-u300/mmc.c
index 8bf466b..5681563 100644
--- a/arch/arm/mach-u300/mmc.c
+++ b/arch/arm/mach-u300/mmc.c
@@ -104,6 +104,7 @@ int __devinit mmc_init(struct amba_device *adev)
 	 * we have a regulator we can control instead.
 	 */
 	/* Nominally 2.85V on our platform */
+	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;
 	mmci_card->mmc0_plat_data.status = mmc_status;
 	mmci_card->mmc0_plat_data.gpio_wp = -1;
 	mmci_card->mmc0_plat_data.gpio_cd = -1;
-- 
1.6.3.3
