From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 May 2015 12:53:07 +0200
Subject: [PATCH] ARM: ux500: get rid of static maps
Message-ID: <1431514387-26209-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static mappings of the GPIO blocks, clock/reset controller
and MTU timer are clearly superfluous. These are all probed
exclusively from the device tree. Tested on the U8500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi ARM SoC-guys: please apply this single clean-up patch
directly to the ARM SoC-tree where apropriate.
---
 arch/arm/mach-ux500/cpu-db8500.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 6f63954c8bde..537a7753afc1 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -48,25 +48,14 @@ static struct map_desc u8500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
 };
+
 /*  U8500 and U9540 common io_desc */
 static struct map_desc u8500_common_io_desc[] __initdata = {
 	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
 	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
-
-	__IO_DEV_DESC(U8500_CLKRST1_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST2_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST3_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST5_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST6_BASE, SZ_4K),
-
-	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
 };
 
 /* U8500 IO map specific description */
-- 
1.9.3
