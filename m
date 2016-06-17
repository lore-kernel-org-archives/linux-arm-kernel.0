From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:10 +0100
Subject: [PATCH 6/9] ARM: fix missing <asm/cacheflush.h> in
 arch/arm/mm/pageattr.c
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix missing declarations in arch/arm/mm/pageattr.c by including
<asm/cacheflush.h>. Fixes:

arch/arm/mm/pageattr.c:71:5: warning: symbol 'set_memory_ro' was not declared. Should it be static?
arch/arm/mm/pageattr.c:78:5: warning: symbol 'set_memory_rw' was not declared. Should it be static?
arch/arm/mm/pageattr.c:85:5: warning: symbol 'set_memory_nx' was not declared. Should it be static?
arch/arm/mm/pageattr.c:92:5: warning: symbol 'set_memory_x' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/pageattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index d19b1ad..ef0612d 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 
 #include <asm/pgtable.h>
+#include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
 struct page_change_data {
-- 
2.8.1
