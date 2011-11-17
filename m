From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 17 Nov 2011 22:18:14 +0800
Subject: [PATCH] ARM: CSR: fix build error due to new mdesc->dma_zone_size
Message-ID: <1321539494-5574-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <baohua.song@csr.com>

commit 98b0124f0e2b88 as below  causes this error.
"
ARM: mach-prima2: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
"

Signed-off-by: Barry Song <baohua.song@csr.com>
---
 arch/arm/mach-prima2/prima2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
index ef555c0..a12b689 100644
--- a/arch/arm/mach-prima2/prima2.c
+++ b/arch/arm/mach-prima2/prima2.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <linux/of.h>
-- 
1.7.0.4
