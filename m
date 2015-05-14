From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:13:53 +0200
Subject: [PATCH 10/10] ARM: ux500: delete static resource defines
Message-ID: <1431620033-15214-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros were used in the past to define static resources,
but are not used anymore and have no future, delete them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/setup.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-ux500/setup.h b/arch/arm/mach-ux500/setup.h
index cf5a8736ea9d..1fb6ad2789f1 100644
--- a/arch/arm/mach-ux500/setup.h
+++ b/arch/arm/mach-ux500/setup.h
@@ -26,20 +26,6 @@ extern struct device *ux500_soc_device_init(const char *soc_id);
 
 extern void ux500_timer_init(void);
 
-#define __IO_DEV_DESC(x, sz)	{		\
-	.virtual	= IO_ADDRESS(x),	\
-	.pfn		= __phys_to_pfn(x),	\
-	.length		= sz,			\
-	.type		= MT_DEVICE,		\
-}
-
-#define __MEM_DEV_DESC(x, sz)	{		\
-	.virtual	= IO_ADDRESS(x),	\
-	.pfn		= __phys_to_pfn(x),	\
-	.length		= sz,			\
-	.type		= MT_MEMORY_RWX,		\
-}
-
 extern struct smp_operations ux500_smp_ops;
 extern void ux500_cpu_die(unsigned int cpu);
 
-- 
1.9.3
