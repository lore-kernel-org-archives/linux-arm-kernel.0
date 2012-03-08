From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 16:58:38 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120308165838.c22b95e78c0ae3dd0ab1fea3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap1/board-osk.c between commit ddba6c7f7ec6 ("OMAP1: pass
LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree and
commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
iomap.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap1/board-osk.c
index ef87465,e2d7ae4..0000000
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@@ -34,8 -34,6 +34,7 @@@
  #include <linux/i2c.h>
  #include <linux/leds.h>
  #include <linux/smc91x.h>
 +#include <linux/omapfb.h>
- 
  #include <linux/mtd/mtd.h>
  #include <linux/mtd/partitions.h>
  #include <linux/mtd/physmap.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/b9654d73/attachment.sig>
