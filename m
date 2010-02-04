From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 11:09:22 -0800
Subject: [RFC PATCH 1/3] [ARM] allow NR_IRQS to be larger than 256
Message-ID: <f17812d71002041109u3d7ea08ej201708fa462e087d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit fc14e7ca387688ca63eafa16d4aa3012898d096d
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Mon Dec 28 11:05:55 2009 +0800

    [ARM] allow NR_IRQS to be larger than 256

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 182310b..6d7485a 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -12,7 +12,9 @@ typedef struct {

 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */

-#if NR_IRQS > 256
+#if NR_IRQS > 512
+#define HARDIRQ_BITS	10
+#elif NR_IRQS > 256
 #define HARDIRQ_BITS	9
 #else
 #define HARDIRQ_BITS	8
