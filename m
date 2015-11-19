From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 13:41:53 +0100
Subject: [PATCH] mm: include linux/pfn.h for PHYS_PFN definition
Message-ID: <5841074.QcbTqgbsZz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A change to asm-generic/memory_model.h caused a new build error
in some configurations:

mach-clps711x/common.c:39:10: error: implicit declaration of function 'PHYS_PFN'
   .pfn  = __phys_to_pfn(CLPS711X_PHYS_BASE),

This includes the linux/pfn.h header from the same file to avoid the
error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bf1c6c9895de ("mm: add PHYS_PFN, use it in __phys_to_pfn()")
---
I was listed as 'Cc' on the original patch, but don't see it in my inbox.

I can queue up the fixed version in the asm-generic tree if you like that,
otherwise please fold this fixup into the patch, or drop it if we want to
avoid the extra #include.

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index c785a79d9385..5148150cc80b 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MEMORY_MODEL_H
 #define __ASM_MEMORY_MODEL_H
 
+#include <linux/pfn.h>
+
 #ifndef __ASSEMBLY__
 
 #if defined(CONFIG_FLATMEM)
