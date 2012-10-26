From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Oct 2012 14:27:08 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20121026142708.394d5ef1e6e3b9ad19243cc6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-ux500/cpu-db8500.c between commit 63c53906312f
("pinctrl/nomadik: move the platform data header") from the pinctrl tree
and commit 4040d10a3d44 ("ARM: ux500: add DB serial number to entropy
pool") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-ux500/cpu-db8500.c
index 87a8f9f,50202a1..0000000
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@@ -18,7 -18,7 +18,8 @@@
  #include <linux/io.h>
  #include <linux/mfd/abx500/ab8500.h>
  #include <linux/platform_data/usb-musb-ux500.h>
 +#include <linux/platform_data/pinctrl-nomadik.h>
+ #include <linux/random.h>
  
  #include <asm/pmu.h>
  #include <asm/mach/map.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/4327182d/attachment.sig>
