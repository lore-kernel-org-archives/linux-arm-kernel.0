From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  3 Nov 2011 23:30:46 +0800
Subject: [PATCH] at91: vmalloc fix missing AT91_VIRT_BASE define
Message-ID: <1320334246-16457-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

break during the this merge

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/vmalloc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/vmalloc.h b/arch/arm/mach-at91/include/mach/vmalloc.h
index 8eb459f..8e4a1bd 100644
--- a/arch/arm/mach-at91/include/mach/vmalloc.h
+++ b/arch/arm/mach-at91/include/mach/vmalloc.h
@@ -21,6 +21,8 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
+#include <mach/hardware.h>
+
 #define VMALLOC_END		(AT91_VIRT_BASE & PGDIR_MASK)
 
 #endif
-- 
1.7.7
