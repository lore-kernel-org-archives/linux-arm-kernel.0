From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:41:08 +0100
Subject: [PATCH] ARM64: use linux/types.h in kvm.h
Message-ID: <9679324.UdV9GV0mFA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should always use linux/types.h instead of asm/types.h for
consistency, and Kbuild actually warns about it:

./usr/include/asm/kvm.h:35: include of <linux/types.h> is preferred over <asm/types.h>

This patch does as Kbuild asks us.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on ARM64 allmodconfig

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 0cd7b5947dfc..2d4ca4bb0dd3 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -32,7 +32,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/psci.h>
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/ptrace.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
