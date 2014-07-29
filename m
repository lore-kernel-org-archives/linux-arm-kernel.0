From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 29 Jul 2014 18:19:49 +1000
Subject: linux-next: manual merge of the gpio tree with the arm-soc tree
Message-ID: <20140729181949.427a7fb5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Today's linux-next merge of the gpio tree got a conflict in
arch/arm/mach-tegra/board-paz00.c between commit a0524acc94c9 ("ARM:
tegra: Sort includes alphabetically") from the arm-soc tree and commit
0a6d315827ee ("gpio: split gpiod board registration into machine
header") from the gpio tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/board-paz00.c
index bb4782a32713,91fd858ced0d..000000000000
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@@ -17,10 -17,9 +17,10 @@@
   *
   */
  
- #include <linux/gpio/driver.h>
 -#include <linux/platform_device.h>
+ #include <linux/gpio/machine.h>
 +#include <linux/platform_device.h>
  #include <linux/rfkill-gpio.h>
 +
  #include "board.h"
  
  static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/f81142a9/attachment.sig>
