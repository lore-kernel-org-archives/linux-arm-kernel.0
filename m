From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Thu, 8 Oct 2009 14:33:13 -0700
Subject: [PATCH] bcmring: add oprofile pmu support
Message-ID: <20091008213313.GQ4708@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch is to add oprofile pmu support for bcmring arch.

Thanks,

Leo

From: Leo Chen <leochen@broadcom.com>
Date: Thu, 8 Oct 2009 14:28:35 -0700
Subject: [PATCH] bcmring: add oprofile pmu support

oprofile pmu support for bcmring arch.

Signed-off-by: Leo Hao Chen <leochen@broadcom.com>
---
 arch/arm/oprofile/op_model_v6.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/op_model_v6.c b/arch/arm/oprofile/op_model_v6.c
index fe58138..f7d2ec5 100644
--- a/arch/arm/oprofile/op_model_v6.c
+++ b/arch/arm/oprofile/op_model_v6.c
@@ -33,6 +33,9 @@ static int irqs[] = {
 #ifdef CONFIG_ARCH_OMAP2
 	3,
 #endif
+#ifdef CONFIG_ARCH_BCMRING
+	IRQ_PMUIRQ, /* for BCMRING, ARM PMU interrupt is 43 */
+#endif
 };
 
 static void armv6_pmu_stop(void)
-- 
1.6.0.6

-- 

Leo Hao Chen

------------------------
Life is short, run long.
