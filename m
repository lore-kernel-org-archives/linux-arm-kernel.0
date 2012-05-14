From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 18:47:46 +1000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20120514184746.3eef413d8e27a6b874e5cd1d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mtd/nand/gpmi-nand/gpmi-nand.c between commit 2890c63138a4 ("mtd:
gpmi: add device tree support to gpmi-nand") from the l2-mtd tree and
commit 39febc018bd2 ("mtd: nand: gpmi: adopt pinctrl support") from the
arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 95f2af8,8478fd9..0000000
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@@ -24,8 -24,7 +24,9 @@@
  #include <linux/module.h>
  #include <linux/mtd/gpmi-nand.h>
  #include <linux/mtd/partitions.h>
 +#include <linux/of.h>
 +#include <linux/of_device.h>
+ #include <linux/pinctrl/consumer.h>
  #include "gpmi-nand.h"
  
  /* add our owner bbt descriptor */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/66a7d110/attachment.sig>
