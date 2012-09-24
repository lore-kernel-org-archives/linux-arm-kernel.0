From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:44:13 +1000
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20120924194413.87981dcbe729777af104d2c5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/spi/spi-davinci.c between commit 048177ce3b39 ("spi: spi-davinci:
convert to DMA engine API") from the slave-dma tree and commit
ec2a0833e515 ("ARM: davinci: move platform_data definitions") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/spi/spi-davinci.c
index c1ec52d,3afe2f4..0000000
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@@ -32,7 -30,8 +32,7 @@@
  #include <linux/spi/spi_bitbang.h>
  #include <linux/slab.h>
  
- #include <mach/spi.h>
+ #include <linux/platform_data/spi-davinci.h>
 -#include <mach/edma.h>
  
  #define SPI_NO_RESOURCE		((resource_size_t)-1)
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/3744330b/attachment.sig>
