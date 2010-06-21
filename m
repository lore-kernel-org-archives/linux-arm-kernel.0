From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 22:22:33 +0800
Subject: [PATCH 2/3] [ARM] pxa: remove useless NODE_MEM_SIZE_BITS
In-Reply-To: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
References: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277130154-25912-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As DISCONTIGMEM is not enabled on PXA, remove this useless bit.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/memory.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
index f626730..81fd4a0 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -17,18 +17,6 @@
  */
 #define PHYS_OFFSET	UL(0xa0000000)
 
-/*
- * The nodes are matched with the physical SDRAM banks as follows:
- *
- * 	node 0:  0xa0000000-0xa3ffffff	-->  0xc0000000-0xc3ffffff
- * 	node 1:  0xa4000000-0xa7ffffff	-->  0xc4000000-0xc7ffffff
- * 	node 2:  0xa8000000-0xabffffff	-->  0xc8000000-0xcbffffff
- * 	node 3:  0xac000000-0xafffffff	-->  0xcc000000-0xcfffffff
- *
- * This needs a node mem size of 26 bits.
- */
-#define NODE_MEM_SIZE_BITS	26
-
 #if !defined(__ASSEMBLY__) && defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
 void cmx2xx_pci_adjust_zones(int node, unsigned long *size,
 			     unsigned long *holes);
-- 
1.7.1
