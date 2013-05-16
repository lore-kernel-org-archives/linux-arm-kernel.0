From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 16 May 2013 14:10:48 +0300
Subject: [PATCH v2 03/10] frv: uaccess s/might_sleep/might_fault/
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
Message-ID: <89d860b7fb23b35e6a15beda9df6ebccf820a2f6.1368702323.git.mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/frv/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/frv/include/asm/uaccess.h b/arch/frv/include/asm/uaccess.h
index 0b67ec5..3ac9a59 100644
--- a/arch/frv/include/asm/uaccess.h
+++ b/arch/frv/include/asm/uaccess.h
@@ -280,14 +280,14 @@ extern long __memcpy_user(void *dst, const void *src, unsigned long count);
 static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-       might_sleep();
+       might_fault();
        return __copy_to_user_inatomic(to, from, n);
 }
 
 static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-       might_sleep();
+       might_fault();
        return __copy_from_user_inatomic(to, from, n);
 }
 
-- 
MST
