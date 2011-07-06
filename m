From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:23 -0400
Subject: [PATCH 38/52] ARM: mach-s5p64x0: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-38-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-s5p64x0/mach-smdk6440.c |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 2d559f1..8810ee6 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -199,7 +199,7 @@ static void __init smdk6440_machine_init(void)
 
 MACHINE_START(SMDK6440, "SMDK6440")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P64X0_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6440_init_irq,
 	.map_io		= smdk6440_map_io,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index d19c469..2d4a269 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -218,7 +218,7 @@ static void __init smdk6450_machine_init(void)
 
 MACHINE_START(SMDK6450, "SMDK6450")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
-	.boot_params	= S5P64X0_PA_SDRAM + 0x100,
+	.atag_offset	= 0x100,
 
 	.init_irq	= s5p6450_init_irq,
 	.map_io		= smdk6450_map_io,
-- 
1.7.4
