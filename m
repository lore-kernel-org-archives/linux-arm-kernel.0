From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 16:50:03 +0100
Subject: [PATCH] dmaengine: ste_dma40_ll: make d40_width_to_bits static
Message-ID: <1465314603-28909-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix warning due to d40_width_to_bits() not being used outside
this file. Fixes:

drivers/dma/ste_dma40_ll.c:13:4: warning: symbol 'd40_width_to_bits' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: dmaengine at vger.kernel.org
---
 drivers/dma/ste_dma40_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index 27b818d..13b42dd 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -10,7 +10,7 @@
 
 #include "ste_dma40_ll.h"
 
-u8 d40_width_to_bits(enum dma_slave_buswidth width)
+static u8 d40_width_to_bits(enum dma_slave_buswidth width)
 {
 	if (width == DMA_SLAVE_BUSWIDTH_1_BYTE)
 		return STEDMA40_ESIZE_8_BIT;
-- 
2.8.1
