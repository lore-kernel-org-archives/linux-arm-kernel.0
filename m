From: nixiaoming@huawei.com (nixiaoming)
Date: Mon, 28 May 2018 11:33:53 +0800
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180528033353.54725-1-nixiaoming@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 arch/arm64/mm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9..849f326 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -491,6 +491,7 @@ static void __init map_mem(pgd_t *pgdp)
 #endif
 }
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
 void mark_rodata_ro(void)
 {
 	unsigned long section_size;
@@ -505,6 +506,7 @@ void mark_rodata_ro(void)
 
 	debug_checkwx();
 }
+#endif
 
 static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 				      pgprot_t prot, struct vm_struct *vma,
-- 
2.10.1
