From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:39:34 +1000
Subject: linux-next: manual merge of the arm-soc tree with the l2-mtd tree
Message-ID: <20120924193934.76d4feafb689b265ff49c5c3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mtd/nand/orion_nand.c between commit 11a3910e730e ("mtd:
orion_nand: remove <mach/hardware.h> include") from the l2-mtd tree and
commit c02cecb92ed4 ("ARM: orion: move platform_data definitions") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mtd/nand/orion_nand.c
index 9ee436d,131b58a..0000000
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@@ -21,7 -21,8 +21,7 @@@
  #include <linux/err.h>
  #include <asm/io.h>
  #include <asm/sizes.h>
- #include <plat/orion_nand.h>
 -#include <mach/hardware.h>
+ #include <linux/platform_data/mtd-orion_nand.h>
  
  static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
  {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/1ef9c797/attachment.sig>
