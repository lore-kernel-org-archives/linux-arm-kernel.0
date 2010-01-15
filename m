From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 15 Jan 2010 02:07:10 -0700
Subject: [PATCH 17/18] OMAP clock: resolve all remaining sparse warnings
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Message-ID: <20100115090708.30690.78226.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolve all remaining sparse warnings in the OMAP clock code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c              |    2 +-
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e0f72f4..0ae2753 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(clk_get_parent);
  * OMAP specific clock functions shared between omap1 and omap2
  *-------------------------------------------------------------------------*/
 
-unsigned int __initdata mpurate;
+int __initdata mpurate;
 
 /*
  * By default we use the rate set by the bootloader.
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 896cedc..e413132 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -123,7 +123,7 @@ struct clk_functions {
 #endif
 };
 
-extern unsigned int mpurate;
+extern int mpurate;
 
 extern int clk_init(struct clk_functions *custom_clocks);
 extern void clk_preinit(struct clk *clk);
