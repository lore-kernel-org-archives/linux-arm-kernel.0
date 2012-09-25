From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:44:58 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120925164458.8c856b4b20f77879a0173e71@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
sound/soc/omap/omap-mcbsp.c between commit 04564e325830 ("ASoC: OMAP:
mcbsp, mcpdm, dmic: Let omap-pcm to pick the dma_type") from the sound
tree and commits 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal")
and 2203747c9771 ("ARM: omap: move platform_data definitions") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc sound/soc/omap/omap-mcbsp.c
index fef2f59,1b186277..0000000
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@@ -34,7 -32,9 +34,8 @@@
  #include <sound/initval.h>
  #include <sound/soc.h>
  
- #include <plat/mcbsp.h>
+ #include <plat/cpu.h>
 -#include <plat/dma.h>
+ #include <linux/platform_data/asoc-ti-mcbsp.h>
  #include "mcbsp.h"
  #include "omap-mcbsp.h"
  #include "omap-pcm.h"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/d2c90b6e/attachment.sig>
