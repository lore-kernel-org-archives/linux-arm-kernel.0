From: salyzyn@android.com (Mark Salyzyn)
Date: Fri,  4 Aug 2017 10:17:00 -0700
Subject: [PATCH] arm64: compat: Remove leftover variable declaration
Message-ID: <20170804171710.21736-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Commit a1d5ebaf8ccd ("arm64: big-endian: don't treat code as data when
copying sigret code") moved the 32-bit sigreturn trampoline code from
the aarch32_sigret_code array to kuser32.S. The commit removed the
array definition from signal32.c, but not its declaration in
signal32.h. Remove the leftover declaration.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 arch/arm64/include/asm/signal32.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index eeaa97559bab..81abea0b7650 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -22,8 +22,6 @@
 
 #define AARCH32_KERN_SIGRET_CODE_OFFSET	0x500
 
-extern const compat_ulong_t aarch32_sigret_code[6];
-
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
