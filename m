From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 11 Jul 2018 16:41:49 +0900
Subject: [PATCH v11 01/15] asm-generic: add kexec_file_load system call to
 unistd.h
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Message-ID: <20180711074203.3019-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 42990676a55e..c81f4a0df51f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_kexec_file_load 293
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
-- 
2.17.0
