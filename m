From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 14:45:12 +0100
Subject: [PATCH 2/2] arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ
In-Reply-To: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
References: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
Message-ID: <1532526312-26993-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/ defines a SIGMINSTKSZ of 2k, so we should use the same value
for compat tasks.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: Steve McIntyre <steve.mcintyre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 1a037b94eba1..cee28a05ee98 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -159,6 +159,7 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 }
 
 #define compat_user_stack_pointer() (user_stack_pointer(task_pt_regs(current)))
+#define COMPAT_MINSIGSTKSZ	2048
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
-- 
2.1.4
