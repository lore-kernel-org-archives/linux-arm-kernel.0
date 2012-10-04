From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 4 Oct 2012 14:33:11 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20121004143311.e04a99036b0b6c519444d615@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/x86/include/asm/Kbuild between commit 10b63956fce7 ("UAPI: Plumb the
UAPI Kbuilds into the user header installation and checking") from Linus'
tree and commit e7a570ff7dff ("asm-generic: Add default clkdev.h") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/x86/include/asm/Kbuild
index 1595d68,66e5f0e..0000000
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@@ -22,3 -22,9 +22,5 @@@ header-y += sigcontext32.
  header-y += ucontext.h
  header-y += vm86.h
  header-y += vsyscall.h
+ 
 -genhdr-y += unistd_32.h
 -genhdr-y += unistd_64.h
 -genhdr-y += unistd_x32.h
 -
+ generic-y += clkdev.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121004/0c841f55/attachment.sig>
