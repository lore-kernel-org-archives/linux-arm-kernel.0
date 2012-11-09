From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 9 Nov 2012 13:31:11 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20121109133111.1070c1062889461152713978@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/pinctrl/pinctrl-nomadik.c between commit 241e51ebd3b2
("pinctrl/nomadik: make independent of prcmu driver") from the pinctrl
tree and commit 44e47ccf8ab6 ("Merge branch 'next/multiplatform' into
for-next") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pinctrl/pinctrl-nomadik.c
index 33c614e,3ad23fb..0000000
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@@ -30,10 -30,23 +30,9 @@@
  #include <linux/pinctrl/pinconf.h>
  /* Since we request GPIOs from ourself */
  #include <linux/pinctrl/consumer.h>
 -/*
 - * For the U8500 archs, use the PRCMU register interface, for the older
 - * Nomadik, provide some stubs. The functions using these will only be
 - * called on the U8500 series.
 - */
 -#ifdef CONFIG_ARCH_U8500
 -#include <linux/mfd/dbx500-prcmu.h>
 -#else
 -static inline u32 prcmu_read(unsigned int reg) {
 -	return 0;
 -}
 -static inline void prcmu_write(unsigned int reg, u32 value) {}
 -static inline void prcmu_write_masked(unsigned int reg, u32 mask, u32 value) {}
 -#endif
  #include <linux/platform_data/pinctrl-nomadik.h>
- 
  #include <asm/mach/irq.h>
- 
+ #include <mach/irqs.h>
  #include "pinctrl-nomadik.h"
  
  /*
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121109/81ef2148/attachment.sig>
