From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Dec 2013 14:42:56 +0100
Subject: [PATCH] ARM: ux500: delete U8549 UART auxdata
Message-ID: <1386078176-3036-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The other Ux500's does not need this anymore, and the U8540
certainly is no different.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 840452b89fc2..75ce3b14bc71 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -170,10 +170,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 };
 
 static struct of_dev_auxdata u8540_auxdata_lookup[] __initdata = {
-	/* Requires DMA bindings. */
-	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", NULL),
-	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", NULL),
-	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", NULL),
 	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
 			&db8500_prcmu_pdata),
 	{},
-- 
1.8.3.1
