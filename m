From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:06 -0400
Subject: [PATCH 21/52] ARM: mach-ks8695: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-21-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ks8695/board-acs5k.c  |    2 +-
 arch/arm/mach-ks8695/board-dsm320.c |    2 +-
 arch/arm/mach-ks8695/board-micrel.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index 3ca4f8e..a5fcc7c 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -223,7 +223,7 @@ static void __init acs5k_init(void)
 
 MACHINE_START(ACS5K, "Brivo Systems LLC ACS-5000 Master board")
 	/* Maintainer: Simtec Electronics. */
-	.boot_params	= KS8695_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
 	.init_machine	= acs5k_init,
diff --git a/arch/arm/mach-ks8695/board-dsm320.c b/arch/arm/mach-ks8695/board-dsm320.c
index ada92b6..197f67b 100644
--- a/arch/arm/mach-ks8695/board-dsm320.c
+++ b/arch/arm/mach-ks8695/board-dsm320.c
@@ -121,7 +121,7 @@ static void __init dsm320_init(void)
 
 MACHINE_START(DSM320, "D-Link DSM-320 Wireless Media Player")
 	/* Maintainer: Simtec Electronics. */
-	.boot_params	= KS8695_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
 	.init_machine	= dsm320_init,
diff --git a/arch/arm/mach-ks8695/board-micrel.c b/arch/arm/mach-ks8695/board-micrel.c
index c7ad09b..cdd309a 100644
--- a/arch/arm/mach-ks8695/board-micrel.c
+++ b/arch/arm/mach-ks8695/board-micrel.c
@@ -53,7 +53,7 @@ static void __init micrel_init(void)
 
 MACHINE_START(KS8695, "KS8695 Centaur Development Board")
 	/* Maintainer: Micrel Semiconductor Inc. */
-	.boot_params	= KS8695_SDRAM_PA + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ks8695_map_io,
 	.init_irq	= ks8695_init_irq,
 	.init_machine	= micrel_init,
-- 
1.7.4
