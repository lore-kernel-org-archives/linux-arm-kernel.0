From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:14 +0800
Subject: [PATCH 2/6] [ARM] footbridge: remove the useless definition of
	__mem_pci()
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-3-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-footbridge/include/mach/io.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-footbridge/include/mach/io.h b/arch/arm/mach-footbridge/include/mach/io.h
index c65ed51..d3b14d2 100644
--- a/arch/arm/mach-footbridge/include/mach/io.h
+++ b/arch/arm/mach-footbridge/include/mach/io.h
@@ -21,18 +21,6 @@
  * Translation of various region addresses to virtual addresses
  */
 #define __io(a)			((void __iomem *)(PCIO_BASE + (a)))
-#if 1
 #define __mem_pci(a)		(a)
-#else
-
-static inline void __iomem *___mem_pci(void __iomem *p)
-{
-	unsigned long a = (unsigned long)p;
-	BUG_ON(a <= 0xc0000000 || a >= 0xe0000000);
-	return p;
-}
-
-#define __mem_pci(a)		___mem_pci(a)
-#endif
 
 #endif
-- 
1.7.1
