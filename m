From: keescook@chromium.org (Kees Cook)
Date: Wed,  4 Mar 2015 17:27:01 -0800
Subject: [PATCH v3 1/8] seccomp: allow COMPAT sigreturn overrides
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Message-ID: <1425518828-16017-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some architectures may need to override the compat sigreturn definition,
as is already possible in the non-compat case.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/seccomp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/seccomp.h b/include/asm-generic/seccomp.h
index 9fa1f653ed3b..c9ccafa0d99a 100644
--- a/include/asm-generic/seccomp.h
+++ b/include/asm-generic/seccomp.h
@@ -17,7 +17,9 @@
 #define __NR_seccomp_read_32		__NR_read
 #define __NR_seccomp_write_32		__NR_write
 #define __NR_seccomp_exit_32		__NR_exit
+#ifndef __NR_seccomp_sigreturn_32
 #define __NR_seccomp_sigreturn_32	__NR_rt_sigreturn
+#endif
 #endif /* CONFIG_COMPAT && ! already defined */
 
 #define __NR_seccomp_read		__NR_read
-- 
1.9.1
