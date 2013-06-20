From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Jun 2013 17:14:52 +1000
Subject: linux-next: manual merge of the arm-soc tree with the tip tree
Message-ID: <20130620171452.365bf173b71870c690d52e27@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/clocksource/dw_apb_timer_of.c between commits 0a0a7e66fa26
("clocksource: dw_apb: Remove unused header") and 38ff87f77af0
("sched_clock: Make ARM's sched_clock generic for all architectures")
from the tip tree and commit a8b447f2bbbb ("clocksource: dw_apb_timer_of:
add clock-handling") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/dw_apb_timer_of.c
index d9a1e8d,cef5544..0000000
--- a/drivers/clocksource/dw_apb_timer_of.c
+++ b/drivers/clocksource/dw_apb_timer_of.c
@@@ -20,8 -20,11 +20,9 @@@
  #include <linux/of.h>
  #include <linux/of_address.h>
  #include <linux/of_irq.h>
 +#include <linux/sched_clock.h>
+ #include <linux/clk.h>
  
 -#include <asm/mach/time.h>
 -#include <asm/sched_clock.h>
 -
  static void timer_get_base_and_rate(struct device_node *np,
  				    void __iomem **base, u32 *rate)
  {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/b89191cf/attachment.sig>
