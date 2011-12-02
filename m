From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Dec 2011 12:21:25 -0800
Subject: [PATCH 07/23] ARM: plat-omap: remove arch specific special
 handling for ioremap
In-Reply-To: <1321422521-1138-8-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-8-git-send-email-nico@fluxnic.net>
Message-ID: <20111202202125.GZ31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

* Nicolas Pitre <nico@fluxnic.net> [111115 21:21]:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> A generic version should replace this later.
> 
> As io.c has become nearly empty, omap_init_consistent_dma_size() is moved
> into common.c so that io.c can be removed entirely.

Sorry for the delay on trying this series out. It boots fine
on omap2/3/4 as Kevin already noted. However, the following
fix is needed for this patch to keep things building for
omap1_defconfig.
 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

With the following fix it works on what I tested. That's
osk5912 n800 2430sdp n900 zoom3 and blaze. If you're still
taking acks for this series:

Tested-by: Tony Lindgren <tony@atomide.com>


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 2 Dec 2011 12:14:28 -0800
Subject: [PATCH] ARM: OMAP: Fix build error for omap1_defconfig

Otherwise we get the following error:

In function 'omap_init_consistent_dma_size':
error: implicit declaration of function 'init_consistent_dma_size'

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
 #include <linux/omapfb.h>
 
 #include <plat/common.h>
