From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:43 +0000
Subject: [RFC PATCH v3 01/11] arm64: compat: Remove leftover variable
 declaration
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-2-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a1d5ebaf8ccd ("arm64: big-endian: don't treat code as data when
copying sigret code") moved the 32-bit sigreturn trampoline code from
the aarch32_sigret_code array to kuser32.S. The commit removed the
array definition from signal32.c, but not its declaration in
signal32.h. Remove the leftover declaration.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
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
2.10.2
