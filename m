From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Aug 2014 14:37:08 +0100
Subject: [PATCH 2/2] asm-generic: add memfd_create system call to unistd.h
In-Reply-To: <1407764228-7904-1-git-send-email-will.deacon@arm.com>
References: <1407764228-7904-1-git-send-email-will.deacon@arm.com>
Message-ID: <1407764228-7904-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9183df25fe7b ("shm: add memfd_create() syscall") added a new
system call (memfd_create) but didn't update the asm-generic unistd
header.

This patch adds the new system call to the asm-generic version of
unistd.h so that it can be used by architectures such as arm64.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f1afd607f043..11d11bc5c78f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -703,9 +703,11 @@ __SYSCALL(__NR_renameat2, sys_renameat2)
 __SYSCALL(__NR_seccomp, sys_seccomp)
 #define __NR_getrandom 278
 __SYSCALL(__NR_getrandom, sys_getrandom)
+#define __NR_memfd_create 279
+__SYSCALL(__NR_memfd_create, sys_memfd_create)
 
 #undef __NR_syscalls
-#define __NR_syscalls 279
+#define __NR_syscalls 280
 
 /*
  * All syscalls below here should go away really,
-- 
2.0.1
