From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:09 +0100
Subject: [PATCH 5/9] ARM: fix missing <linux/elf-randomize.h> in
 arch/arm/mm/mmap.c
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The declaration of arch_mmap_rnd() is missing so fix it by
including <linux/elf-randomize.h>. Fixes:

/arch/arm/mm/mmap.c:172:15: warning: symbol 'arch_mmap_rnd' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 66353ca..ac8de3a 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/elf-randomize.h>
 #include <asm/cachetype.h>
 
 #define COLOUR_ALIGN(addr,pgoff)		\
-- 
2.8.1
