From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:28 +0800
Subject: [PATCH 7/7] Minor compiling fix
In-Reply-To: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
Message-ID: <1329126268-11032-8-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/mm/Makefile      |    1 +
 arch/arm/mm/dma-mapping.c |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index bca7e61..9348e1e 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -99,4 +99,5 @@ AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
 obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlb.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1aa664a..8dc5fb4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -152,9 +152,6 @@ static struct arm_vmregion_head consistent_head = {
 	.vm_end		= CONSISTENT_END,
 };
 
-#ifdef CONFIG_HUGETLB_PAGE
-#error ARM Coherent DMA allocator does not (yet) support huge TLB
-#endif
 
 /*
  * Initialise the consistent memory allocation.
-- 
1.7.1
