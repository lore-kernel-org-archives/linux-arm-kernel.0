From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  5 Oct 2017 14:56:53 +0200
Subject: [PATCH 1/3] arm/xen: don't inclide rwlock.h directly.
Message-ID: <20171005125655.12373-1-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rwlock.h should not be included directly. Instead linux/splinlock.h
should be included. One thing it does is to break the RT build.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel at lists.xenproject.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/xen/p2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index e71eefa2e427..0641ba54ab62 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -1,7 +1,7 @@
 #include <linux/bootmem.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
-#include <linux/rwlock.h>
+#include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/dma-mapping.h>
-- 
2.14.2
