From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 16 May 2013 14:15:58 +0300
Subject: [PATCH v2 09/10] x86: uaccess s/might_sleep/might_fault/
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
Message-ID: <4fe705ad6d48e166bfe77c1401140008eac8f6f6.1368702323.git.mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 142810c..4f7923d 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -235,7 +235,7 @@ extern long __copy_user_nocache(void *dst, const void __user *src,
 static inline int
 __copy_from_user_nocache(void *dst, const void __user *src, unsigned size)
 {
-	might_sleep();
+	might_fault();
 	return __copy_user_nocache(dst, src, size, 1);
 }
 
-- 
MST
