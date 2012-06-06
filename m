From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Jun 2012 11:27:23 +0200
Subject: [PATCH] ARM: mm: fix type of the arm_dma_limit global variable
In-Reply-To: <20120605220744.GB29782@n2100.arm.linux.org.uk>
References: <20120605220744.GB29782@n2100.arm.linux.org.uk>
Message-ID: <1338974843-5079-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_dma_limit stores physical address of maximal address accessible by DMA,
so the phys_addr_t type makes much more sence for it instead of u32. This
patch fixes the following build warning:

arch/arm/mm/init.c:380: warning: comparison of distinct pointer types lacks a cast

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 8f5813b..39f2a86 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -211,7 +211,7 @@ EXPORT_SYMBOL(arm_dma_zone_size);
  * allocations.  This must be the smallest DMA mask in the system,
  * so a successful GFP_DMA allocation will always satisfy this.
  */
-u32 arm_dma_limit;
+phys_addr_t arm_dma_limit;
 
 static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 	unsigned long dma_size)
-- 
1.7.1.569.g6f426
