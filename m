From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:10:53 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20120924191053.e0fbf9e8d43a7a83115f2bcc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/board-rx51-peripherals.c between commit 322c183cdc5f
("[media] ARM: mach-omap2: board-rx51-peripherals: Add lirc-rx51 data")
from the v4l-dvb tree and commits 2203747c9771 ("ARM: omap: move
platform_data definitions") and 606281525fb7 ("ARM: OMAP2+: Make
gpmc-smc91x.h local") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-rx51-peripherals.c
index ca07264,3945c50..0000000
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@@ -30,13 -33,9 +33,10 @@@
  #include "common.h"
  #include <plat/dma.h>
  #include <plat/gpmc.h>
- #include <plat/onenand.h>
- #include <plat/gpmc-smc91x.h>
 +#include <plat/omap-pm.h>
+ #include "gpmc-smc91x.h"
  
- #include <mach/board-rx51.h>
+ #include "board-rx51.h"
  
  #include <sound/tlv320aic3x.h>
  #include <sound/tpa6130a2-plat.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/a1fa44d9/attachment.sig>
