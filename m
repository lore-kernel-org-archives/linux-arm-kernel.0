From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 6 Sep 2011 17:06:23 +0200
Subject: [PATCH] arm: omap: Fix build error in ispccdc.c
In-Reply-To: <1315317735-5255-1-git-send-email-joerg.roedel@amd.com>
References: <1315317735-5255-1-git-send-email-joerg.roedel@amd.com>
Message-ID: <201109061706.26776.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Tuesday 06 September 2011 16:02:15 Joerg Roedel wrote:
> The following build error occurs with 3.1-rc5:
>
>   CC      drivers/media/video/omap3isp/ispccdc.o
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c: In
> function 'ccdc_lsc_config':
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c:42
> 7:2: error: implicit declaration of function 'kzalloc'
> [-Werror=implicit-function-declaration]
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c:42
> 7:6: warning: assignment makes pointer from integer without a cast [enabled
> by default]
> 
> This patch adds the missing 'linux/slab.h' include to fix the problem.

Thanks for the patch.

> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Mauro, can you please pick this patch and push it to v3.1 ?

> ---
>  drivers/media/video/omap3isp/ispccdc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/omap3isp/ispccdc.c
> b/drivers/media/video/omap3isp/ispccdc.c index 9d3459d..80796eb 100644
> --- a/drivers/media/video/omap3isp/ispccdc.c
> +++ b/drivers/media/video/omap3isp/ispccdc.c
> @@ -31,6 +31,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/mm.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
>  #include <media/v4l2-event.h>
> 
>  #include "isp.h"

-- 
Regards,

Laurent Pinchart
