From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:28:44 +1000
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20120924192844.51a4fa2f92ba220b1fec68d4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/dma/mmp_tdma.c between commit f1a7757008b8 ("dmaengine: mmp_tdma:
add dt support") from the slave-dma tree and commit 293b2da1b611 ("ARM:
pxa: move platform_data definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/dma/mmp_tdma.c
index b93d73c,07fa486..0000000
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@@ -19,8 -19,7 +19,8 @@@
  #include <linux/platform_device.h>
  #include <linux/device.h>
  #include <mach/regs-icu.h>
- #include <mach/sram.h>
 +#include <linux/of_device.h>
+ #include <linux/platform_data/dma-mmp_tdma.h>
  
  #include "dmaengine.h"
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/9bc83610/attachment.sig>
