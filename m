From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 16:47:05 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120925164705.602503e31a0c29e88bbc9066@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
sound/soc/omap/omap-pcm.c between commit 946cc36ae550 ("ASoC: omap-pcm:
Convert to use dmaengine") from the sound tree and commit 7d7e1eba7e92
("ARM: OMAP2+: Prepare for irqs.h removal") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc sound/soc/omap/omap-pcm.c
index a2636f6,b309941..0000000
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@@ -29,9 -28,10 +29,10 @@@
  #include <sound/core.h>
  #include <sound/pcm.h>
  #include <sound/pcm_params.h>
 +#include <sound/dmaengine_pcm.h>
  #include <sound/soc.h>
  
+ #include <plat/cpu.h>
 -#include <plat/dma.h>
  #include "omap-pcm.h"
  
  static const struct snd_pcm_hardware omap_pcm_hardware = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/d0999cbd/attachment.sig>
