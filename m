From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 1 Dec 2014 13:52:41 +1100
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
Message-ID: <20141201135241.435ecb37@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in
arch/arm/mach-omap2/board-rx51-peripherals.c between commit
e639cd5bfc03 ("ARM: OMAP2+: Prepare to move GPMC to drivers by platform
data header") from the arm-soc tree and commit 68a3c0433077 ("[media]
ARM: OMAP2: RX-51: update si4713 platform data") from the v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-rx51-peripherals.c
index e2ad48b5d9c0,ec2e4101988b..000000000000
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@@ -23,7 -23,7 +23,8 @@@
  #include <linux/regulator/machine.h>
  #include <linux/gpio.h>
  #include <linux/gpio_keys.h>
+ #include <linux/gpio/machine.h>
 +#include <linux/omap-gpmc.h>
  #include <linux/mmc/host.h>
  #include <linux/power/isp1704_charger.h>
  #include <linux/platform_data/spi-omap2-mcspi.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/97d434f4/attachment.sig>
