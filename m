From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 17:32:53 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120924173253.ffdff508e51d05f667b76bde@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-davinci/dm355.c between commit 896f66b7de29 ("ASoC/ARM:
Davinci: McASP: split asp header into platform and audio specific") from
the sound tree and commit ec2a0833e515 ("ARM: davinci: move platform_data
definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/dm355.c
index e47a3f0,adbde33..0000000
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@@ -26,7 -26,8 +26,7 @@@
  #include <mach/time.h>
  #include <mach/serial.h>
  #include <mach/common.h>
- #include <mach/spi.h>
 -#include <mach/asp.h>
+ #include <linux/platform_data/spi-davinci.h>
  #include <mach/gpio-davinci.h>
  
  #include "davinci.h"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/601e8db2/attachment.sig>
