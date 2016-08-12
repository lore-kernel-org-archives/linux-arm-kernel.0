From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 12 Aug 2016 16:01:09 +0800
Subject: [PATCH v3 2/4] arm64: vdso: constify vm_special_mapping used for
 aarch32 vectors page
In-Reply-To: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
References: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470988871-2799-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vm_special_mapping spec which is used for aarch32 vectors page is
never modified, so mark it as const.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e320e8f..10ad8ab 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -88,7 +88,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = AARCH32_VECTORS_BASE;
-	static struct vm_special_mapping spec = {
+	static const struct vm_special_mapping spec = {
 		.name	= "[vectors]",
 		.pages	= vectors_page,
 
-- 
2.8.1
