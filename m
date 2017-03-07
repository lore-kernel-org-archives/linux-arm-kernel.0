From: labbott@redhat.com (Laura Abbott)
Date: Tue,  7 Mar 2017 12:55:33 -0800
Subject: [PATCHv3 16/16] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Message-ID: <1488920133-27229-17-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that all call sites, completely decouple cacheflush.h and
set_memory.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: No changes
---
 arch/arm/include/asm/cacheflush.h   | 1 -
 arch/arm64/include/asm/cacheflush.h | 1 -
 arch/s390/include/asm/Kbuild        | 1 +
 arch/s390/include/asm/cacheflush.h  | 8 --------
 arch/x86/include/asm/cacheflush.h   | 1 -
 5 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 arch/s390/include/asm/cacheflush.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 1cb9d11..d69bebf 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -16,7 +16,6 @@
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
-#include <asm/set_memory.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 7db6962..5812469 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -20,7 +20,6 @@
 #define __ASM_CACHEFLUSH_H
 
 #include <linux/mm.h>
-#include <asm/set_memory.h>
 
 /*
  * This flag is used to indicate that the page pointed to by a pte is clean
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 8aea32f..c0a7057 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += asm-offsets.h
+generic-y += cacheflush.h
 generic-y += clkdev.h
 generic-y += dma-contiguous.h
 generic-y += export.h
diff --git a/arch/s390/include/asm/cacheflush.h b/arch/s390/include/asm/cacheflush.h
deleted file mode 100644
index afe2965..0000000
--- a/arch/s390/include/asm/cacheflush.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef _S390_CACHEFLUSH_H
-#define _S390_CACHEFLUSH_H
-
-/* Caches aren't brain-dead on the s390. */
-#include <asm-generic/cacheflush.h>
-#include <asm/set_memory.h>
-
-#endif /* _S390_CACHEFLUSH_H */
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index 3d7db6f..8b4140f 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -4,7 +4,6 @@
 /* Caches aren't brain-dead on the intel. */
 #include <asm-generic/cacheflush.h>
 #include <asm/special_insns.h>
-#include <asm/set_memory.h>
 
 void clflush_cache_range(void *addr, unsigned int size);
 
-- 
2.7.4
