From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 19:23:45 +1000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120917192345.10d3b625a5c104183855658f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in drivers/video/omap2/dss/dispc.c between commit fe6a466283cf ("OMAPDSS: remove unnecessary includes") from the omap_dss2 tree and commit 7d7e1eba7e92 ("ARM: OMAP2+: Prepare for irqs.h removal") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/video/omap2/dss/dispc.c
index d512c38,ee9e296..0000000
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@@ -37,6 -37,9 +37,8 @@@
  #include <linux/platform_device.h>
  #include <linux/pm_runtime.h>
  
+ #include <plat/cpu.h>
 -#include <plat/clock.h>
+ 
  #include <video/omapdss.h>
  
  #include "dss.h"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/f9c5a41c/attachment.sig>
