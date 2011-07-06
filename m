From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:32 -0400
Subject: [PATCH 47/52] ARM: mach-ux500: convert boot-params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-47-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    4 ++--
 arch/arm/mach-ux500/board-u5500.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index bb26f40..571eab0 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -462,7 +462,7 @@ static void __init mop500_init_machine(void)
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
@@ -471,7 +471,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 MACHINE_END
 
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
-	.boot_params	= 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 44fd3b5..a3f2a81 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -36,7 +36,7 @@ static void __init u5500_init_machine(void)
 }
 
 MACHINE_START(U5500, "ST-Ericsson U5500 Platform")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= u5500_map_io,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
-- 
1.7.4
