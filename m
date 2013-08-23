From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:13 +0100
Subject: [PATCH 13/40] ARM: ux500: Stop passing GPIO pdata when booitng with
 ATAGs enabled
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-14-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index f185e53..2c4885a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -51,14 +51,9 @@
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
 
-static struct abx500_gpio_platform_data ab8500_gpio_pdata = {
-	.gpio_base		= MOP500_AB8500_PIN_GPIO(1),
-};
-
 struct ab8500_platform_data ab8500_platdata = {
 	.irq_base	= MOP500_AB8500_IRQ_BASE,
 	.regulator	= &ab8500_regulator_plat_data,
-	.gpio		= &ab8500_gpio_pdata,
 };
 
 /*
-- 
1.8.1.2
