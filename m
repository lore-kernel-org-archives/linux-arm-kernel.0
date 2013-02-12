From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 12 Feb 2013 14:59:19 +1100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130212145919.e1f7ba0e693b69f40f5724dd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-zoom-peripherals.c between commit 51482be9dcfd
("ARM: OMAP: USB: Add phy binding information") from the usb tree and
commit c5913935657f ("ARM: OMAP: zoom: Audio support via the common
omap-twl4030 machine driver") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-zoom-peripherals.c
index dc5498b,0745bd9..0000000
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@@ -20,7 -20,7 +20,8 @@@
  #include <linux/wl12xx.h>
  #include <linux/mmc/host.h>
  #include <linux/platform_data/gpio-omap.h>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130212/77b47771/attachment.sig>
