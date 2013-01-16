From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 Jan 2013 13:26:52 +1100
Subject: linux-next: manual merge of the arm-soc tree with the slave-dma tree
Message-ID: <20130116132652.d740bb94b9aaf2a4b41aef6b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/mach-spear3xx/spear3xx.c and arch/arm/mach-spear6xx/spear6xx.c
between commit 3a95b9fbba89 ("pl080.h: moved from
arm/include/asm/hardware to include/linux/amba/") from the slave-dma tree
and commit e9c515589df7 ("ARM: spear: use common irqchip_init function")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-spear3xx/spear3xx.c
index 3d9b1b5,b2ba516..0000000
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@@ -15,10 -15,8 +15,7 @@@
  
  #include <linux/amba/pl022.h>
  #include <linux/amba/pl08x.h>
- #include <linux/irqchip/spear-shirq.h>
- #include <linux/of_irq.h>
  #include <linux/io.h>
- #include <asm/hardware/vic.h>
 -#include <asm/hardware/pl080.h>
  #include <plat/pl080.h>
  #include <mach/generic.h>
  #include <mach/spear.h>
diff --cc arch/arm/mach-spear6xx/spear6xx.c
index 8ce65a2,b8bd33c..0000000
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@@ -16,12 -16,11 +16,11 @@@
  #include <linux/amba/pl08x.h>
  #include <linux/clk.h>
  #include <linux/err.h>
+ #include <linux/irqchip.h>
  #include <linux/of.h>
  #include <linux/of_address.h>
- #include <linux/of_irq.h>
  #include <linux/of_platform.h>
 -#include <asm/hardware/pl080.h>
 +#include <linux/amba/pl080.h>
- #include <asm/hardware/vic.h>
  #include <asm/mach/arch.h>
  #include <asm/mach/time.h>
  #include <asm/mach/map.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130116/65300d55/attachment.sig>
