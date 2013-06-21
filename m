From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 16:45:12 +1000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20130621164512.261ad1e1a0cb27f45e955601@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
include/linux/mfd/davinci_voicecodec.h between commit 997174705458 ("mfd:
davinci_voicecodec: Fix build breakage") from the mfd tree and commit
3ad7a42d5a9c ("ARM: davinci: move private EDMA API to arm/common") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc include/linux/mfd/davinci_voicecodec.h
index 810aee7,7dd6524..0000000
--- a/include/linux/mfd/davinci_voicecodec.h
+++ b/include/linux/mfd/davinci_voicecodec.h
@@@ -26,10 -26,8 +26,10 @@@
  #include <linux/kernel.h>
  #include <linux/platform_device.h>
  #include <linux/mfd/core.h>
+ #include <linux/platform_data/edma.h>
  
- #include <mach/edma.h>
 +#include <mach/hardware.h>
 +
  /*
   * Register values.
   */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/844a8ca6/attachment.sig>
