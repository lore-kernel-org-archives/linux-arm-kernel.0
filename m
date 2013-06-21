From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 17:33:26 +1000
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20130621173326.42120edc7f766a527cef7470@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
arch/arm/mach-picoxcell/common.c between commit 4b83f75a7af3 ("ARM:
picoxcell: Remove init_irq declaration in machine description") from the
arm-soc tree and commit "reboot: arm: change reboot_mode to use enum
reboot_mode" from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-picoxcell/common.c
index b13f51b,37add6d..0000000
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@@ -8,8 -8,13 +8,9 @@@
   * All enquiries to support at picochip.com
   */
  #include <linux/delay.h>
 -#include <linux/irq.h>
 -#include <linux/irqchip.h>
 -#include <linux/irqdomain.h>
+ #include <linux/reboot.h>
  #include <linux/of.h>
  #include <linux/of_address.h>
 -#include <linux/of_irq.h>
  #include <linux/of_platform.h>
  
  #include <asm/mach/arch.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/f0f0c458/attachment.sig>
