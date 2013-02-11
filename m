From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 11 Feb 2013 17:06:10 +1100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130211170610.d3df28e80424e7c8fd9233e3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-3430sdp.c between commit 51482be9dcfd ("ARM:
OMAP: USB: Add phy binding information") from the usb tree and commit
77f86144984e ("ARM: OMAP: sdp3430: Audio support via the common
omap-twl4030 machine driver") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-3430sdp.c
index 2a739b2,4f17339..0000000
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@@ -25,7 -25,7 +25,8 @@@
  #include <linux/gpio.h>
  #include <linux/mmc/host.h>
  #include <linux/platform_data/spi-omap2-mcspi.h>
+ #include <linux/platform_data/omap-twl4030.h>
 +#include <linux/usb/phy.h>
  
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130211/e46b24f8/attachment.sig>
