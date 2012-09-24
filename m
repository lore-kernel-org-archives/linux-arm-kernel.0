From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:31:08 +1000
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20120924193108.f399195b821a835e0d3db08a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mmc/host/davinci_mmc.c between commit b5daabbd3d18 ("mmc:
davinci_mmc: convert to DMA engine API") from the slave-dma tree and
commit ec2a0833e515 ("ARM: davinci: move platform_data definitions") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mmc/host/davinci_mmc.c
index c5e1eeb,3dfd347..0000000
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@@ -30,12 -30,11 +30,12 @@@
  #include <linux/io.h>
  #include <linux/irq.h>
  #include <linux/delay.h>
 +#include <linux/dmaengine.h>
  #include <linux/dma-mapping.h>
 +#include <linux/edma.h>
  #include <linux/mmc/mmc.h>
  
- #include <mach/mmc.h>
+ #include <linux/platform_data/mmc-davinci.h>
 -#include <mach/edma.h>
  
  /*
   * Register Definitions
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/320ce7d8/attachment.sig>
