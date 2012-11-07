From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 7 Nov 2012 14:29:16 +1100
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd and
 pinctrl trees
Message-ID: <20121107142916.824003a6c863320fbf379652@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-nomadik/board-nhk8815.c between commit 1cd2fc449091 ("ARM:
nomadik: fixup some FSMC merge problems") from the l2-mtd tree, commits
bb16bd9b9da4 ("pinctrl/nomadik: move the platform data header") from the
pinctrl and commit 44e47ccf8ab6 ("Merge branch 'next/multiplatform' into
for-next") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-nomadik/board-nhk8815.c
index ab7104f,5ccdf53..0000000
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@@ -30,11 -31,10 +32,9 @@@
  #include <asm/sizes.h>
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
- #include <asm/mach/irq.h>
  #include <asm/mach/flash.h>
  #include <asm/mach/time.h>
- 
- #include <plat/mtu.h>
 -#include <mach/fsmc.h>
+ #include <mach/irqs.h>
  
  #include "cpu-8815.h"
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/e075bca6/attachment.sig>
