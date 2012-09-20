From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:22 +0800
Subject: [PATCH v2 09/34] ARM: imx: include iram.h rather than mach/iram.h
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename mach-imx/include/mach/iram.h to mach-imx/iram.h, and update users
to include iram.h rather than mach/iram.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/{include/mach => }/iram.h |    0
 arch/arm/mach-imx/iram_alloc.c              |    3 ++-
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-imx/{include/mach => }/iram.h (100%)

diff --git a/arch/arm/mach-imx/include/mach/iram.h b/arch/arm/mach-imx/iram.h
similarity index 100%
rename from arch/arm/mach-imx/include/mach/iram.h
rename to arch/arm/mach-imx/iram.h
diff --git a/arch/arm/mach-imx/iram_alloc.c b/arch/arm/mach-imx/iram_alloc.c
index 074c386..6c80424 100644
--- a/arch/arm/mach-imx/iram_alloc.c
+++ b/arch/arm/mach-imx/iram_alloc.c
@@ -22,7 +22,8 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/genalloc.h>
-#include <mach/iram.h>
+
+#include "iram.h"
 
 static unsigned long iram_phys_base;
 static void __iomem *iram_virt_base;
-- 
1.7.9.5
