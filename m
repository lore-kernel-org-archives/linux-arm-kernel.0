From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri,  9 Nov 2012 17:12:00 +0530
Subject: [PATCH 1/1] ARM: mm: Remove unused variable in mmap.c
Message-ID: <1352461320-22031-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Variable 'start_addr' is not used and hence can be removed.

Silences the following compilation warning:
arch/arm/mm/mmap.c: In function ?arch_get_unmapped_area?:
arch/arm/mm/mmap.c:60:16: warning:
unused variable ?start_addr? [-Wunused-variable]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This patch is based linux-next tree of 20121109
---
 arch/arm/mm/mmap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index f4fec6d..10062ce 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -57,7 +57,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
 	struct vm_unmapped_area_info info;
-- 
1.7.4.1
