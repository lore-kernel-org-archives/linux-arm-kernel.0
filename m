From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Dec 2012 16:52:18 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20121203165218.c45a0500dcdd0a441ae3e7de@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/media/platform/omap/omap_vout.c between commit 950e2fb420d5
("[media] omap_vout: use omapdss's version instead of cpu_is_*") from the
omap_dss2 tree and commit 45c3eb7d3a07 ("ARM: OMAP: Move
plat-omap/dma-omap.h to include/linux/omap-dma.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/media/platform/omap/omap_vout.c
index 718e5f6,9935040..0000000
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@@ -44,6 -44,8 +44,7 @@@
  #include <media/v4l2-device.h>
  #include <media/v4l2-ioctl.h>
  
 -#include <plat/cpu.h>
+ #include <linux/omap-dma.h>
  #include <video/omapvrfb.h>
  #include <video/omapdss.h>
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121203/1e116ff9/attachment.sig>
