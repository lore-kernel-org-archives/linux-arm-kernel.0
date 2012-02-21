From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Feb 2012 15:40:40 -0800
Subject: [PATCH 3/8] ARM: OMAP: Move omap_init_consistent_dma_size() to
 local common.h
In-Reply-To: <20120221233619.18709.87982.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
Message-ID: <20120221234040.18709.17025.stgit@kaulin.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want to keep it in io.h as we want to remove io.h
for omap2+ for the common zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/common.h         |    1 +
 arch/arm/mach-omap2/common.h         |    2 ++
 arch/arm/plat-omap/include/plat/io.h |    2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index a9a5146..af658ad 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -58,5 +58,6 @@ void omap1_restart(char, const char *);
 
 extern struct sys_timer omap1_timer;
 extern bool omap_32k_timer_init(void);
+extern void __init omap_init_consistent_dma_size(void);
 
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 5aa1acb..f78ec4e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -133,6 +133,8 @@ void am33xx_map_io(void);
 void omap4_map_io(void);
 void ti81xx_map_io(void);
 
+extern void __init omap_init_consistent_dma_size(void);
+
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index f5b386b..28cd796 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -266,8 +266,6 @@ extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
-extern void __init omap_init_consistent_dma_size(void);
-
 #endif
 
 #endif
