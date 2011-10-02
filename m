From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 15:46:32 +0200
Subject: [PATCH 12/11] ARM: include linux/highmem.h in uaccess functions
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1894078.P7yYjKNL5t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When highpte support is enabled, this is required to build
the kernel.
    
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
I was missing this patch at first, but now found it in the omap branch.

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 8b9b136..025f742 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/hardirq.h> /* for in_atomic() */
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <asm/current.h>
 #include <asm/page.h>
 
