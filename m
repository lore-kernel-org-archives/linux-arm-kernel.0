From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  1 Sep 2013 22:02:08 +0200
Subject: [PATCH 4/4] ARM: nomadik: delete MMCI platform data
Message-ID: <1378065728-18232-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a proper regulator set up for the MMCI driver
and managed through the device tree, we no longer need the
platform data providing the OCR voltages for the MMCI block.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 13e0df9..be7530d 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -190,15 +190,6 @@ static int __init cpu8815_eth_init(void)
 device_initcall(cpu8815_eth_init);
 
 /*
- * TODO:
- * cannot be set from device tree, convert to a proper DT
- * binding.
- */
-static struct mmci_platform_data mmcsd_plat_data = {
-	.ocr_mask = MMC_VDD_29_30,
-};
-
-/*
  * This GPIO pin turns on a line that is used to detect card insertion
  * on this board.
  */
@@ -232,13 +223,10 @@ static int __init cpu8815_mmcsd_init(void)
 }
 device_initcall(cpu8815_mmcsd_init);
 
-
-/* These are mostly to get the right device names for the clock lookups */
+/* This still waits for a device tree enablement patch */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
 		NULL, &cpu8815_nand_data),
-	OF_DEV_AUXDATA("arm,primecell", NOMADIK_SDI_BASE,
-		NULL, &mmcsd_plat_data),
 	{ /* sentinel */ },
 };
 
-- 
1.8.1.4
