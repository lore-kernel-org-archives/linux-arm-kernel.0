From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 14 Sep 2011 17:33:03 +0200
Subject: [PATCH] arm: omap: Fix build error in ispccdc.c
In-Reply-To: <1315317735-5255-1-git-send-email-joerg.roedel@amd.com>
References: <1315317735-5255-1-git-send-email-joerg.roedel@amd.com>
Message-ID: <20110914153303.GW11701@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On Tue, Sep 06, 2011 at 10:02:15AM -0400, Joerg Roedel wrote:
> The following build error occurs with 3.1-rc5:
> 
>   CC      drivers/media/video/omap3isp/ispccdc.o
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c: In function 'ccdc_lsc_config':
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c:427:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
> /home/data/repos/linux.trees.git/drivers/media/video/omap3isp/ispccdc.c:427:6: warning: assignment makes pointer from integer without a cast [enabled by default]
> 
> This patch adds the missing 'linux/slab.h' include to fix the problem.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  drivers/media/video/omap3isp/ispccdc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/media/video/omap3isp/ispccdc.c b/drivers/media/video/omap3isp/ispccdc.c
> index 9d3459d..80796eb 100644
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
> -- 
> 1.7.4.1

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
