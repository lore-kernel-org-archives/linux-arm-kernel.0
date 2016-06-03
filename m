From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Jun 2016 09:50:21 +0100
Subject: [PATCH 3/8] kexec: don't invoke OOM-killer for control page allocation
Message-ID: <E1b8ko9-0004HG-R5@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are unable to find a suitable page when allocating the control
page, do not invoke the OOM-killer: killing processes probably isn't
going to help.

Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/kexec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2cc643c6e870..1b32ab587f66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -41,7 +41,7 @@
 #endif
 
 #ifndef KEXEC_CONTROL_MEMORY_GFP
-#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
+#define KEXEC_CONTROL_MEMORY_GFP (GFP_KERNEL | __GFP_NORETRY)
 #endif
 
 #ifndef KEXEC_CONTROL_PAGE_SIZE
-- 
2.1.0
