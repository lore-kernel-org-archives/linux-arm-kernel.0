From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 16:30:01 +0900
Subject: [PATCH V4 2/3] ARM: S5PV310: Remove L2 cache init in machine
Message-ID: <1287646201-14183-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Basically, need L2 cache initialize function in ARCH_S5PV310. So it would
be better to move it into ARCH_S5PV310 common part. This patch removes L2
cache initialization code at the each board file.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v3:
- Removed useless header in each mach-xxx.c

 arch/arm/mach-s5pv310/mach-smdkc210.c       |    5 -----
 arch/arm/mach-s5pv310/mach-smdkv310.c       |    5 -----
 arch/arm/mach-s5pv310/mach-universal_c210.c |    5 -----
 3 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 93d537b..9f7f77d 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -15,7 +15,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
@@ -129,10 +128,6 @@ static void __init smdkc210_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
 
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
-#endif
-
 	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
 }
 
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 10f8056..e350a75 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -15,7 +15,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
@@ -129,10 +128,6 @@ static void __init smdkv310_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
 
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
-#endif
-
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
 }
 
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
index deffeb1..9ea7836 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
@@ -16,7 +16,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
@@ -141,10 +140,6 @@ static void __init universal_map_io(void)
 
 static void __init universal_machine_init(void)
 {
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
-#endif
-
 	i2c_register_board_info(0, i2c0_devs, ARRAY_SIZE(i2c0_devs));
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 
-- 
1.6.2.5
