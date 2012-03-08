From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 17:00:48 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap1/board-palmtt.c between commit ddba6c7f7ec6 ("OMAP1:
pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
iomap.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap1/board-palmtt.c
index b63350b,acd1f36..0000000
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@@ -24,9 -24,9 +24,10 @@@
  #include <linux/mtd/partitions.h>
  #include <linux/mtd/physmap.h>
  #include <linux/leds.h>
 +#include <linux/omapfb.h>
+ #include <linux/spi/spi.h>
+ #include <linux/spi/ads7846.h>
  
- #include <mach/hardware.h>
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/map.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/d1c73ce5/attachment.sig>
