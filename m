From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:37 +0100
Subject: [PATCH 37/40] ARM: ux500: Remove ATAG booting support for MOP500
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-38-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 8f1b98a..705b0d7 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -96,18 +96,6 @@ static void __init hrefv60_init_machine(void)
 	regulator_has_full_constraints();
 }
 
-MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
-	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
-	.atag_offset	= 0x100,
-	.smp		= smp_ops(ux500_smp_ops),
-	.map_io		= u8500_map_io,
-	.init_irq	= ux500_init_irq,
-	/* we re-use nomadik timer here */
-	.init_time	= ux500_timer_init,
-	.init_machine	= mop500_init_machine,
-	.init_late	= NULL,
-MACHINE_END
-
 MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
-- 
1.8.1.2
