From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Mar 2012 16:55:39 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120308165539.8a3b718be677de97a8767cd5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap1/board-nokia770.c between commit 58e0d6ab02eb ("OMAP:
N770: remove HWA742 platform data") from the omap_dss2 tree and commit
2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local iomap.h")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap1/board-nokia770.c
index 9b6332a,abdbdb0..0000000
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@@ -30,7 -29,7 +29,6 @@@
  #include <plat/usb.h>
  #include <plat/board.h>
  #include <plat/keypad.h>
- #include "common.h"
 -#include <plat/hwa742.h>
  #include <plat/lcd_mipid.h>
  #include <plat/mmc.h>
  #include <plat/clock.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/1283461f/attachment.sig>
