From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 20 Jun 2013 17:09:51 +1000
Subject: linux-next: manual merge of the arm-soc tree with the tip tree
Message-ID: <20130620170951.248631b40c84c30a1a57ba7f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-integrator/integrator_ap.c between commit 38ff87f77af0
("sched_clock: Make ARM's sched_clock generic for all architectures")
from the tip tree and commit 01ef31053ddd ("ARM: integrator: move VGA
base assignment") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-integrator/integrator_ap.c
index aa43462,a5b15c4..0000000
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@@ -41,8 -41,6 +41,7 @@@
  #include <linux/stat.h>
  #include <linux/sys_soc.h>
  #include <linux/termios.h>
 +#include <linux/sched_clock.h>
- #include <video/vga.h>
  
  #include <mach/hardware.h>
  #include <mach/platform.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/4b052602/attachment.sig>
