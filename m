From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  2 Oct 2014 18:46:14 +0900
Subject: [PATCH v7 4/6] arm64: add seccomp syscall for compat task
In-Reply-To: <1412243176-16192-1-git-send-email-takahiro.akashi@linaro.org>
References: <1412243176-16192-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1412243176-16192-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows compat task to issue seccomp() system call.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/unistd32.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index da1f06b..812f192 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -787,7 +787,8 @@ __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 382
 __SYSCALL(__NR_renameat2, sys_renameat2)
-			/* 383 for seccomp */
+#define __NR_seccomp 383
+__SYSCALL(__NR_seccomp, sys_seccomp)
 #define __NR_getrandom 384
 __SYSCALL(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 385
-- 
1.7.9.5
