From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:17:41 -0700
Subject: [PATCH v3 2/3] arm64: Remove custom __early_init_dt_declare_initrd
 implenentation
In-Reply-To: <20181025001742.6510-1-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
Message-ID: <20181025001742.6510-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that drivers/of/fdt.c includes the proper implementation for ARM64,
we can get rid of our custom __early_init_dt_declare_initrd()
implementation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/memory.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
-- 
2.17.1
