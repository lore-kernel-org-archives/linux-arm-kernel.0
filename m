From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 11 Aug 2016 21:36:46 +0800
Subject: [PATCH v2 1/4] arm64: vdso: add __init section marker to
 alloc_vectors_page
In-Reply-To: <1470922609-754-1-git-send-email-jszhang@marvell.com>
References: <1470922609-754-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470922609-754-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not needed after booting, this patch moves the alloc_vectors_page
function to the __init section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 076312b..e320e8f 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -55,7 +55,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
  */
 static struct page *vectors_page[1];
 
-static int alloc_vectors_page(void)
+static int __init alloc_vectors_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
-- 
2.8.1
