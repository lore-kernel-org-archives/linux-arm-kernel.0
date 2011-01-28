From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 28 Jan 2011 08:58:25 +0100
Subject: [PATCH 2/2] mach-ux500: fix inverted SD-card GPIO pin
Message-ID: <1296201505-22896-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@stericsson.com>

The levelshifter pins were set to inverted values, fix this up.

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 4b99667..4ba3d93 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -106,8 +106,8 @@ void mop500_sdi_tc35892_init(void)
 	if (ret)
 		return;
 
-	gpio_direction_output(GPIO_SDMMC_1V8_3V_SEL, 1);
-	gpio_direction_output(GPIO_SDMMC_EN, 0);
+	gpio_direction_output(GPIO_SDMMC_1V8_3V_SEL, 0);
+	gpio_direction_output(GPIO_SDMMC_EN, 1);
 
 	db8500_add_sdi0(&mop500_sdi0_data);
 }
-- 
1.7.3.2
