From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 Jan 2013 13:22:47 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20130116132247.e0a476aa0b5c825931d418e6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-spear13xx/spear1340.c between commit f9965aa20706 ("ARM:
SPEAr13xx: Pass DW DMAC platform data from DT") from the slave-dma tree
and commit 0529e315bbda ("ARM: use common irqchip_init for GIC init")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-spear13xx/spear1340.c
index 69c8f72,9a28beb..0000000
--- a/arch/arm/mach-spear13xx/spear1340.c
+++ b/arch/arm/mach-spear13xx/spear1340.c
@@@ -18,9 -18,9 +18,9 @@@
  #include <linux/delay.h>
  #include <linux/dw_dmac.h>
  #include <linux/of_platform.h>
 +#include <linux/pata_arasan_cf_data.h>
- #include <asm/hardware/gic.h>
+ #include <linux/irqchip.h>
  #include <asm/mach/arch.h>
 -#include <mach/dma.h>
  #include <mach/generic.h>
  #include <mach/spear.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/592b9086/attachment.sig>
