From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 16:18:01 +1000
Subject: linux-next: manual merge of the arm-soc tree with the tip tree
Message-ID: <20130621161801.34c4a75c217ca4c1b7d6529c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-u300/timer.c between commit 38ff87f77af0 ("sched_clock:
Make ARM's sched_clock generic for all architectures") from the tip tree
and commit 3c96d8ea8101 ("ARM: u300: enable delaytimer on the U300") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-u300/timer.c
index af771b7,390ae5f..0000000
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@@ -18,12 -18,12 +18,12 @@@
  #include <linux/clk.h>
  #include <linux/err.h>
  #include <linux/irq.h>
 +#include <linux/sched_clock.h>
- 
- #include <mach/hardware.h>
- #include <mach/irqs.h>
+ #include <linux/delay.h>
+ #include <linux/of_address.h>
+ #include <linux/of_irq.h>
  
  /* Generic stuff */
 -#include <asm/sched_clock.h>
  #include <asm/mach/map.h>
  #include <asm/mach/time.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/4e90a67b/attachment.sig>
