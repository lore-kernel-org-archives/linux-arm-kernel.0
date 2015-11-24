From: mkarthi3@visteon.com (Mutharaju, Prasanna (P.))
Date: Tue, 24 Nov 2015 06:56:03 +0000
Subject: [PATCH] ARM:VDSO: use PTR_ERR_OR_ZERO for vma check
Message-ID: <20151124065536.GA21679@jci-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Karthik <mkarthi3@visteon.com>

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 arch/arm/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 54a5aea..994e971 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -224,7 +224,7 @@ static int install_vvar(struct mm_struct *mm, unsigned long addr)
 				       VM_READ | VM_MAYREAD,
 				       &vdso_data_mapping);
 
-	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
+	return PTR_ERR_OR_ZERO(vma);
 }
 
 /* assumes mmap_sem is write-locked */
-- 
1.9.1
