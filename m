From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 18 Jul 2013 22:34:54 +0400
Subject: [PATCH 03/10] ARM: clps711x: autcpu12: Remove incorrect config
 checking
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374172501-26796-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes incorrect config symbols checking since these
symbols not contain "CONFIG_" prefix. Anyway, checking is unneeded
here and this patch remove it completely.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 5867aeb..f8d71a8 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -259,11 +259,7 @@ static void __init autcpu12_init(void)
 static void __init autcpu12_init_late(void)
 {
 	gpio_request_array(autcpu12_gpios, ARRAY_SIZE(autcpu12_gpios));
-
-	if (IS_ENABLED(MTD_NAND_GPIO) && IS_ENABLED(GPIO_GENERIC_PLATFORM)) {
-		/* We are need both drivers to handle NAND */
-		platform_device_register(&autcpu12_nand_pdev);
-	}
+	platform_device_register(&autcpu12_nand_pdev);
 }
 
 MACHINE_START(AUTCPU12, "autronix autcpu12")
-- 
1.8.1.5
