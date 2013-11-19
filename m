From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 22:49:04 +0100
Subject: [PATCH] ARM: ux500: delete Nomadik pinctrl AUXDATA
Message-ID: <1384897744-30801-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This deletes the AUXDATA hammering down the Nomadik pin
controller name to "pinctrl-db8500". We have removed all
dependencies on this name.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 0b5b27b4a7b4..448906054817 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -167,9 +167,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("stericsson,ux500-hash", 0xa03c2000, "hash1", NULL),
 	OF_DEV_AUXDATA("stericsson,snd-soc-mop500", 0, "snd-soc-mop500.0",
 			NULL),
-	/* Requires device name bindings. */
-	OF_DEV_AUXDATA("stericsson,db8500-pinctrl", U8500_PRCMU_BASE,
-		"pinctrl-db8500", NULL),
 	{},
 };
 
-- 
1.8.3.1
