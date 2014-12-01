From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 1 Dec 2014 15:22:02 +1100
Subject: linux-next: manual merge of the mmc-uh tree with the arm-soc tree
Message-ID: <20141201152202.5a1b4978@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

Today's linux-next merge of the mmc-uh tree got a conflict in
arch/arm/mach-omap2/board-n8x0.c between commit e639cd5bfc03 ("ARM:
OMAP2+: Prepare to move GPMC to drivers by platform data header") from
the arm-soc tree and commit 826c71a06588 ("ARM: OMAP2: MMC: include
mmc-omap platform header directly") from the mmc-uh tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-n8x0.c
index 49c3c25808e7,e0ad64fde20e..000000000000
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@@ -21,7 -21,10 +21,9 @@@
  #include <linux/i2c.h>
  #include <linux/spi/spi.h>
  #include <linux/usb/musb.h>
+ #include <linux/mmc/host.h>
  #include <linux/platform_data/spi-omap2-mcspi.h>
 -#include <linux/platform_data/mtd-onenand-omap2.h>
+ #include <linux/platform_data/mmc-omap.h>
  #include <linux/mfd/menelaus.h>
  #include <sound/tlv320aic3x.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/5cd72491/attachment.sig>
