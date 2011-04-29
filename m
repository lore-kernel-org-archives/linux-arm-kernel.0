From: robherring2@gmail.com (Rob Herring)
Date: Thu, 28 Apr 2011 22:18:08 -0500
Subject: [PATCH] clk: don't include mach/clkdev.h for common struct clk
Message-ID: <1304047088-30131-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Machine __clk_get/put definitions conflict with common struct clk definitions.

The whole point of a common struct clk is to share same definitions, so
machine specific definitions should not get included.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---

Jeremy,

Can you add this to your tree or just merge into your patch.

Rob

 arch/arm/include/asm/clkdev.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index 765d332..bf27fb4 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -14,7 +14,9 @@
 
 #include <linux/slab.h>
 
+#ifndef CONFIG_USE_COMMON_STRUCT_CLK
 #include <mach/clkdev.h>
+#endif
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
-- 
1.7.1
