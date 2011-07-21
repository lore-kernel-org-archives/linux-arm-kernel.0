From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 21 Jul 2011 12:51:35 -0400
Subject: [PATCH] ARM: add highmem.h to lib/uaccess_with_memcpy.c
Message-ID: <1311267095-15228-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This compile failure was discovered during an allyesconfig:

arch/arm/lib/uaccess_with_memcpy.c: In function 'pin_page_for_write':
arch/arm/lib/uaccess_with_memcpy.c:45: error: implicit declaration of function 'kmap_atomic'
arch/arm/lib/uaccess_with_memcpy.c:48: error: implicit declaration of function 'kunmap_atomic'
make[2]: *** [arch/arm/lib/uaccess_with_memcpy.o] Error 1

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 8b9b136..66945a6 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <linux/rwsem.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
-- 
1.7.6
