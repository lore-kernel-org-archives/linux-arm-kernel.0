From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 31 Dec 2015 21:07:59 +0200
Subject: [PATCH v2 17/32] arm: define __smp_xxx
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
Message-ID: <1451572003-2440-18-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defines __smp_xxx barriers for arm,
for use by virtualization.

smp_xxx barriers are removed as they are
defined correctly by asm-generic/barriers.h

This reduces the amount of arch-specific boiler-plate code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/barrier.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 31152e8..112cc1a 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -60,15 +60,9 @@ extern void arm_heavy_mb(void);
 #define dma_wmb()	barrier()
 #endif
 
-#ifndef CONFIG_SMP
-#define smp_mb()	barrier()
-#define smp_rmb()	barrier()
-#define smp_wmb()	barrier()
-#else
-#define smp_mb()	dmb(ish)
-#define smp_rmb()	smp_mb()
-#define smp_wmb()	dmb(ishst)
-#endif
+#define __smp_mb()	dmb(ish)
+#define __smp_rmb()	__smp_mb()
+#define __smp_wmb()	dmb(ishst)
 
 #include <asm-generic/barrier.h>
 
-- 
MST
