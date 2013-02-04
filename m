From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 4 Feb 2013 17:04:21 +1100
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20130204170421.1dd829d596474b12c12190df@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/mfd/db8500-prcmu.c between commit 5073e7b57041 ("mfd:
db8500-prcmu: Add ux500_wdt mfd_cell") from the mfd tree and commit
520f7bd73354 ("irqchip: Move ARM gic.h to
include/linux/irqchip/arm-gic.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/mfd/db8500-prcmu.c
index e42a417,42f3afc..0000000
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@@ -32,8 -33,6 +33,7 @@@
  #include <linux/regulator/db8500-prcmu.h>
  #include <linux/regulator/machine.h>
  #include <linux/cpufreq.h>
 +#include <linux/platform_data/ux500_wdt.h>
- #include <asm/hardware/gic.h>
  #include <mach/hardware.h>
  #include <mach/irqs.h>
  #include <mach/db8500-regs.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/4814b64b/attachment.sig>
