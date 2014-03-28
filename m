From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:19:33 +0000
Subject: [PATCH 60/75] ARM: l2c: shmobile: remove cache size override
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYZB-0007Gv-AO@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c           | 2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c           | 2 +-
 arch/arm/mach-shmobile/board-kzm9g.c                     | 2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c                   | 2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c                   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 34e7f3c17dd2..39e11f48e8bc 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -165,7 +165,7 @@ static void __init eva_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
 #endif
 
 	r8a7740_add_standard_devices_dt();
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 69ec71038ec7..179f455d96c7 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1271,7 +1271,7 @@ static void __init eva_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00440000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 85873f186d77..a735a1d80c28 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -37,7 +37,7 @@ static void __init kzm_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
 #endif
 }
 
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index bd9931f223ae..4c4cb64e99fe 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -879,7 +879,7 @@ static void __init kzm_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
-	l2x0_init(IOMEM(0xf0100000), 0x00460000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 3a8e5316671e..6dd7ddf88741 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -301,7 +301,7 @@ void __init r8a7778_add_dt_devices(void)
 		 * Shared attribute override enable, 64K*16way
 		 * don't call iounmap(base)
 		 */
-		l2x0_init(base, 0x00470000, 0xc2000fff);
+		l2x0_init(base, 0x00400000, 0xc20f0fff);
 	}
 #endif
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 91c90bf0ae83..a6630fccfc45 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -701,7 +701,7 @@ void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*16way */
-	l2x0_init(IOMEM(0xf0100000), 0x00470000, 0xc2000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
 #endif
 	r8a7779_pm_init();
 
-- 
1.8.3.1
