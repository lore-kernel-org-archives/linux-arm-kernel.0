From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Apr 2013 16:02:56 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20130405160256.7ca6f52e25e0d2231eb1fcfe@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
drivers/irqchip/irq-s3c24xx.c between commit de88cbb7b244 ("arm: Move
chained_irq_(enter|exit) to a generic file") from the arm-soc tree (where
it is called arch/arm/mach-s3c24xx/irq.c) and commit f0774d41da0e
("irqchip: s3c24xx: add devicetree support") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/irqchip/irq-s3c24xx.c
index 8296d94,5e40b34..0000000
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@@ -25,8 -25,11 +25,12 @@@
  #include <linux/ioport.h>
  #include <linux/device.h>
  #include <linux/irqdomain.h>
 +#include <linux/irqchip/chained_irq.h>
+ #include <linux/of.h>
+ #include <linux/of_irq.h>
+ #include <linux/of_address.h>
  
+ #include <asm/exception.h>
  #include <asm/mach/irq.h>
  
  #include <mach/regs-irq.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/d09ba861/attachment.sig>
