From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Oct 2012 13:32:48 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm64 tree
Message-ID: <20121005133248.cca53b84a9dace0c1052a502@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm64/include/asm/unistd32.h between commit cce72b4219ee ("arm64:
Use the generic compat_sys_sendfile() implementation") from the arm64
tree and commit 890139529d45 ("UAPI: Fix the guards on various
asm/unistd.h files") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm64/include/asm/unistd32.h
index ec61180,3ba1f1a..0000000
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@@ -754,6 -752,3 +752,4 @@@ __SYSCALL(__NR_syncfs, sys_syncfs
  #define __ARCH_WANT_SYS_SIGPENDING
  #define __ARCH_WANT_SYS_SIGPROCMASK
  #define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
 +#define __ARCH_WANT_COMPAT_SYS_SENDFILE
- 
- #endif /* __ASM_UNISTD32_H */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121005/7d8ec9f4/attachment-0001.sig>
