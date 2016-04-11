From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 11 Apr 2016 10:17:46 +0100
Subject: [PATCH] generic syscalls: wire up preadv2 and pwritev2 syscalls
Message-ID: <1460366266-29378-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These new syscalls are implemented as generic code, so enable them for
architectures like arm64 which use the generic syscall table.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/uapi/asm-generic/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2622b33..6e0f5f0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -717,9 +717,13 @@ __SYSCALL(__NR_membarrier, sys_membarrier)
 __SYSCALL(__NR_mlock2, sys_mlock2)
 #define __NR_copy_file_range 285
 __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
+#define __NR_preadv2 286
+__SYSCALL(__NR_preadv2, sys_preadv2)
+#define __NR_pwritev2 287
+__SYSCALL(__NR_pwritev2, sys_pwritev2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 286
+#define __NR_syscalls 288
 
 /*
  * All syscalls below here should go away really,
-- 
2.7.3
