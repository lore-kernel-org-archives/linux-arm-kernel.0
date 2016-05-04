From: yang.shi@linaro.org (Yang Shi)
Date: Wed,  4 May 2016 11:14:27 -0700
Subject: [PATCH] arm64: mm: remove unnecessary EXPORT_SYMBOL_GPL
Message-ID: <1462385667-21022-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch_pick_mmap_layout is only called by fs/exec.c which is always built into
kernel, it looks the EXPORT_SYMBOL_GPL is pointless and no architectures export
it other than ARM64.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 232f787..01c1717 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -95,8 +95,6 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
-EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
-
 
 /*
  * You really shouldn't be using read() or write() on /dev/mem.  This might go
-- 
2.0.2
