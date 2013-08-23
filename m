From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:27 +0100
Subject: [PATCH 27/40] ARM: ux500: Stop initialising the pinmaps when booting
 with ATAGs
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-28-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 939ba22..0ae083b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -154,7 +154,6 @@ static void __init mop500_init_machine(void)
 
 	platform_device_register(&db8500_prcmu_device);
 
-	mop500_pinmaps_init();
 	parent = u8500_init_devices();
 
 	mop500_uart_init(parent);
@@ -169,7 +168,6 @@ static void __init snowball_init_machine(void)
 
 	platform_device_register(&db8500_prcmu_device);
 
-	snowball_pinmaps_init();
 	parent = u8500_init_devices();
 
 	mop500_uart_init(parent);
@@ -184,7 +182,6 @@ static void __init hrefv60_init_machine(void)
 
 	platform_device_register(&db8500_prcmu_device);
 
-	hrefv60_pinmaps_init();
 	parent = u8500_init_devices();
 
 	mop500_uart_init(parent);
-- 
1.8.1.2
