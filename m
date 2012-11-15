From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Nov 2012 11:47:19 +0100
Subject: [PATCH] ARM: ux500: fix pin warning
Message-ID: <1352976439-24133-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Recent pin changes produce this warning:

arch/arm/mach-ux500/board-mop500-pins.c:73:22:
error: 'out_hi_wkup_pdis' defined but not used
[-Werror=unused-variable]

Fix this by deleting the offending definition.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 5770ed0..6679d8a 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -71,8 +71,6 @@ BIAS(in_wkup_pdis_en, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_SLPM_PDIS_ENABLED);
 BIAS(in_wkup_pdis, PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_SLPM_PDIS_DISABLED);
-BIAS(out_hi_wkup_pdis, PIN_SLPM_OUTPUT_HIGH|PIN_SLPM_WAKEUP_ENABLE|
-	PIN_SLPM_PDIS_DISABLED);
 BIAS(out_wkup_pdis, PIN_SLPM_DIR_OUTPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_SLPM_PDIS_DISABLED);
 
-- 
1.7.11.3
