From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 23 Jan 2013 16:30:36 +1100
Subject: linux-next: manual merge of the tegra tree with the arm-soc tree
Message-ID: <20130123163036.4791935db9e9539c4313c97f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tegra tree got a conflict in
arch/arm/mach-tegra/platsmp.c between commit 520f7bd73354 ("irqchip: Move
ARM gic.h to include/linux/irqchip/arm-gic.h") from the arm-soc tree and
commit 4c6e1ff5b5fe ("ARM: tegra: move tegra_cpu_car.h to
linux/clk/tegra.h") from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/platsmp.c
index 18d7290,3ec7fc4..0000000
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@@ -18,11 -18,13 +18,13 @@@
  #include <linux/jiffies.h>
  #include <linux/smp.h>
  #include <linux/io.h>
 +#include <linux/irqchip/arm-gic.h>
+ #include <linux/clk/tegra.h>
  
  #include <asm/cacheflush.h>
 -#include <asm/hardware/gic.h>
  #include <asm/mach-types.h>
  #include <asm/smp_scu.h>
+ #include <asm/smp_plat.h>
  
  #include <mach/powergate.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130123/e1eae94b/attachment.sig>
