From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 18:26:56 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120924182656.c0daf6d68a9d1447ace4bf8a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-davinci/dm365.c between commit 896f66b7de29 ("ASoC/ARM:
Davinci: McASP: split asp header into platform and audio specific") from
the  tree and commit ec2a0833e515 ("ARM: davinci: move platform_data
definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/dm365.c
index f473745,719e22f..0000000
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@@ -29,8 -29,9 +29,8 @@@
  #include <mach/time.h>
  #include <mach/serial.h>
  #include <mach/common.h>
- #include <mach/keyscan.h>
- #include <mach/spi.h>
 -#include <mach/asp.h>
+ #include <linux/platform_data/keyscan-davinci.h>
+ #include <linux/platform_data/spi-davinci.h>
  #include <mach/gpio-davinci.h>
  
  #include "davinci.h"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/bdea21d7/attachment.sig>
