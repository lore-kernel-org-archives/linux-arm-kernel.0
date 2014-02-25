From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Feb 2014 15:25:48 +1100
Subject: linux-next: manual merge of the watchdog tree with the mvebu tree
Message-ID: <20140225152548.65ba8372349800898f109fb2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

Today's linux-next merge of the watchdog tree got a conflict in
drivers/watchdog/orion_wdt.c between commit e97662e1e28d ("watchdog:
orion: Handle the interrupt so it's properly acked") from the mvebu tree
and commit 2e9a2ff49520 ("watchdog: delete non-required instances of
include <linux/init.h>") from the watchdog tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/watchdog/orion_wdt.c
index 15321aa0bb94,498163497c1c..000000000000
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@@ -18,9 -18,8 +18,8 @@@
  #include <linux/kernel.h>
  #include <linux/platform_device.h>
  #include <linux/watchdog.h>
- #include <linux/init.h>
 +#include <linux/interrupt.h>
  #include <linux/io.h>
 -#include <linux/spinlock.h>
  #include <linux/clk.h>
  #include <linux/err.h>
  #include <linux/of.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/cf37f45b/attachment.sig>
