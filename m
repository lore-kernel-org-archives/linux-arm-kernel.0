From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Tue, 6 May 2014 07:40:56 +0800
Subject: [PATCH] ARM: LPAE: Update the comment to support the LPAE
Message-ID: <1399333256-10471-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the LPAE maybe enabled, so we should update the comment
to support it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/kernel/head.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 914616e..005af2d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -29,10 +29,10 @@
 
 /*
  * swapper_pg_dir is the virtual address of the initial page table.
- * We place the page tables 16K below KERNEL_RAM_VADDR.  Therefore, we must
- * make sure that KERNEL_RAM_VADDR is correctly set.  Currently, we expect
- * the least significant 16 bits to be 0x8000, but we could probably
- * relax this restriction to KERNEL_RAM_VADDR >= PAGE_OFFSET + 0x4000.
+ * We place the page tables PG_DIR_SIZE below KERNEL_RAM_VADDR. Therefore,
+ * we must make sure that KERNEL_RAM_VADDR is correctly set. Currently,
+ * we expect the least significant 16 bits to be 0x8000, but we could probably
+ * relax this restriction to KERNEL_RAM_VADDR >= PAGE_OFFSET + PG_DIR_SIZE.
  */
 #define KERNEL_RAM_VADDR	(PAGE_OFFSET + TEXT_OFFSET)
 #if (KERNEL_RAM_VADDR & 0xffff) != 0x8000
-- 
1.8.4
