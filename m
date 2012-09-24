From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 19:15:08 +1000
Subject: linux-next: manual merge of the arm-soc tree with the fbdev tree
Message-ID: <20120924191508.6100b0603d2642c1e7a36679@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in arch/arm/mach-s3c64xx/mach-mini6410.c between commit 5a213a55c6d3 ("include/video: move fimd register headers from platform to include/video") from the fbdev tree and commit 436d42c61c3e ("ARM: samsung: move platform_data definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-s3c64xx/mach-mini6410.c
index 96ebcc5,09311cc..0000000
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@@ -38,12 -38,12 +38,12 @@@
  #include <plat/cpu.h>
  #include <plat/devs.h>
  #include <plat/fb.h>
- #include <plat/nand.h>
+ #include <linux/platform_data/mtd-nand-s3c2410.h>
  #include <plat/regs-serial.h>
- #include <plat/ts.h>
+ #include <linux/platform_data/touchscreen-s3c2410.h>
 -#include <plat/regs-fb-v4.h>
  
  #include <video/platform_lcd.h>
 +#include <video/samsung_fimd.h>
  
  #include "common.h"
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/a97e13b0/attachment.sig>
