From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 16:50:30 +0900
Subject: [PATCH v2 2/3] ARM: S5PC210: Remove L2 cache init at board file
Message-ID: <20100930075030.GA11808@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Remove S5PC210 common PL310 cache init code. It will place the cpu common code.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkv310.c       |    3 ---
 arch/arm/mach-s5pv310/mach-universal_c210.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 0d6ab77..a0c630d 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -74,9 +74,6 @@ static void __init smdkv310_map_io(void)
 
 static void __init smdkv310_machine_init(void)
 {
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
-#endif
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
diff --git a/arch/arm/mach-s5pv310/mach-universal_c210.c b/arch/arm/mach-s5pv310/mach-universal_c210.c
index 2388cb9..4612823 100644
--- a/arch/arm/mach-s5pv310/mach-universal_c210.c
+++ b/arch/arm/mach-s5pv310/mach-universal_c210.c
@@ -69,9 +69,6 @@ static void __init universal_map_io(void)
 
 static void __init universal_machine_init(void)
 {
-#ifdef CONFIG_CACHE_L2X0
-	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
-#endif
 }
 
 MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
-- 
1.5.3.3
