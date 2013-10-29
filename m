From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 29 Oct 2013 19:00:21 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20131029190021.bb2dddcbd46e1ddfdfd5e441@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/opp.c between commit e4db1c7439b3 ("PM / OPP: rename
header to linux/pm_opp.h") from the pm tree and commit 92d51856d740
("ARM: OMAP3+: do not register non-dt OPP tables for device tree boot")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/opp.c
index ec21e6eb03e1,82fd8c72f750..000000000000
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@@ -17,7 -17,8 +17,8 @@@
   * GNU General Public License for more details.
   */
  #include <linux/module.h>
+ #include <linux/of.h>
 -#include <linux/opp.h>
 +#include <linux/pm_opp.h>
  #include <linux/cpu.h>
  
  #include "omap_device.h"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/cb107310/attachment.sig>
