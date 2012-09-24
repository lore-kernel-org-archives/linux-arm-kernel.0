From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 18:30:49 +1000
Subject: linux-next: manual merge of the arm-soc tree with the sound tree
Message-ID: <20120924183049.44bc374d9dc8b8504e504d99@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-davinci/include/mach/da8xx.h between commit 896f66b7de29
(ASoC/ARM: Davinci: McASP: split asp header into platform and audio
specific"") from the sound tree and commit ec2a0833e515 ("ARM: davinci:
move platform_data definitions") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/include/mach/da8xx.h
index c74a6ab,33e78ae..0000000
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@@ -20,11 -19,12 +20,11 @@@
  
  #include <mach/serial.h>
  #include <mach/edma.h>
- #include <mach/i2c.h>
- #include <mach/mmc.h>
- #include <mach/usb.h>
 -#include <mach/asp.h>
  #include <mach/pm.h>
- #include <mach/spi.h>
+ #include <linux/platform_data/i2c-davinci.h>
+ #include <linux/platform_data/mmc-davinci.h>
+ #include <linux/platform_data/usb-davinci.h>
+ #include <linux/platform_data/spi-davinci.h>
  
  extern void __iomem *da8xx_syscfg0_base;
  extern void __iomem *da8xx_syscfg1_base;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/5b911ac5/attachment.sig>
