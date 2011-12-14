From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 14 Dec 2011 09:22:13 +0100
Subject: [PATCH] ux500: remove overlapping iotable entries
Message-ID: <1323850933-3084-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The overlapping iotable mapping entries for the ux500 Cortex
A9 SCU, CPU control and TWD are no longer accepted by the
kernel. Remove the overlaps so the machine boots again.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/cpu-db5500.c |    5 ++---
 arch/arm/mach-ux500/cpu-db8500.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 9de1af0..5323286 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -30,12 +30,11 @@ static struct map_desc u5500_uart_io_desc[] __initdata = {
 };
 
 static struct map_desc u5500_io_desc[] __initdata = {
-	__IO_DEV_DESC(U5500_GIC_CPU_BASE, SZ_4K),
+	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
+	__IO_DEV_DESC(U5500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_TWD_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_MTU0_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_BACKUPRAM0_BASE, SZ_8K),
 
 	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 13e8890..7f2729c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -35,12 +35,11 @@ static struct map_desc u8500_uart_io_desc[] __initdata = {
 };
 
 static struct map_desc u8500_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
+	/* SCU base also covers GIC CPU BASE and TWD with its 4K page */
+	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
 
 	__IO_DEV_DESC(U8500_CLKRST1_BASE, SZ_4K),
-- 
1.7.3.2
