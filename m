From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 31 Oct 2012 16:19:21 +1100
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
Message-ID: <20121031161921.3c9a46bd03f5864eed88fc87@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-omap2/drm.c between commit 5e3b08749951 ("staging:
drm/omap: add support for ARCH_MULTIPLATFORM") from the staging tree and
commit 2a296c8f89bc ("ARM: OMAP: Make plat/omap_hwmod.h local to
mach-omap2") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-omap2/drm.c
index 49a7ffb,6282cc8..0000000
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@@ -23,11 -23,9 +23,11 @@@
  #include <linux/init.h>
  #include <linux/platform_device.h>
  #include <linux/dma-mapping.h>
 +#include <linux/platform_data/omap_drm.h>
  
- #include <plat/omap_device.h>
- #include <plat/omap_hwmod.h>
+ #include "omap_device.h"
+ #include "omap_hwmod.h"
 +#include <plat/cpu.h>
  
  #if defined(CONFIG_DRM_OMAP) || (CONFIG_DRM_OMAP_MODULE)
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/76478ec8/attachment.sig>
