From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 17:30:24 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120924173024.f102e9efb9b24d2b275509be@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-davinci/davinci.h between commit 896f66b7de29 ("ASoC/ARM:
Davinci: McASP: split asp header into platform and audio specific") from
the sound tree and commit ec2a0833e515 ("ARM: davinci: move platform_data
definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/davinci.h
index 8661b20,a37fc44..0000000
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@@ -22,11 -22,10 +22,11 @@@
  #include <linux/davinci_emac.h>
  #include <linux/platform_device.h>
  #include <linux/spi/spi.h>
 +#include <linux/platform_data/davinci_asp.h>
  
- #include <mach/keyscan.h>
 -#include <mach/asp.h>
+ #include <linux/platform_data/keyscan-davinci.h>
  #include <mach/hardware.h>
 +#include <mach/edma.h>
  
  #include <media/davinci/vpfe_capture.h>
  #include <media/davinci/vpif_types.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/97a83b48/attachment.sig>
