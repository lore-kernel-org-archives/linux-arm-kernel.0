From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 15:24:24 -0400
Subject: [PATCH] [ARM] mmp: add dma support
Message-ID: <mailman.330.1272457304.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMA support in MMP2.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index da5cd9d..7f5eb05 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -22,6 +22,7 @@
 #include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
+#include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/gpio.h>
 #include <mach/devices.h>
@@ -149,6 +150,7 @@ static int __init mmp2_init(void)
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
+		pxa_init_dma(IRQ_MMP2_DMA_RIQ, 16);
 		clkdev_add_table(ARRAY_AND_SIZE(mmp2_clkregs));
 	}

-- 
1.5.6.5
