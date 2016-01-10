From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 16:22:05 +0200
Subject: [PATCH v3 40/41] s390: use generic memory barriers
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Message-ID: <1452426622-4471-41-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s390 kernel is SMP to 99.99%, we just didn't bother with a
non-smp variant for the memory-barriers. If the generic header
is used we'd get the non-smp version for free. It will save a
small amount of text space for CONFIG_SMP=n.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/s390/include/asm/barrier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index fbd25b2..4d26fa4 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -29,9 +29,6 @@
 #define __smp_mb()			mb()
 #define __smp_rmb()			rmb()
 #define __smp_wmb()			wmb()
-#define smp_mb()			__smp_mb()
-#define smp_rmb()			__smp_rmb()
-#define smp_wmb()			__smp_wmb()
 
 #define __smp_store_release(p, v)					\
 do {									\
-- 
MST
