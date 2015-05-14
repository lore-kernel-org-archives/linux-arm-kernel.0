From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:19 +0200
Subject: [PATCH 06/10] ARM: ux500: get rid of SCU and backupram static maps
Message-ID: <1431619999-15054-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving the SMP and PM code to use dynamic mappings from
the device tree, we can delete the static maps for SCU and
backup RAM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index a36fdd8657d2..3562b9aea767 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -45,10 +45,7 @@ static struct prcmu_pdata db8500_prcmu_pdata = {
 
 /*  U8500 and U9540 common io_desc */
 static struct map_desc u8500_common_io_desc[] __initdata = {
-	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
-	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
 };
 
 /* U8500 IO map specific description */
-- 
1.9.3
