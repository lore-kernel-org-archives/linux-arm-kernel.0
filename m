From: rick.chang@mediatek.com (Rick Chang)
Date: Tue, 21 Mar 2017 09:22:15 +0800
Subject: [PATCH 1/2] [media] vcodec: mediatek: add missing linux/slab.h
 include
In-Reply-To: <20170320094812.1365229-1-arnd@arndb.de>
References: <20170320094812.1365229-1-arnd@arndb.de>
Message-ID: <1490059335.27725.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the patch, but someone has fixed the same problem.

Regards,
Rick

On Mon, 2017-03-20 at 10:47 +0100, Arnd Bergmann wrote:
> With the newly added driver, I have run into randconfig failures like:
> 
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c: In function 'mtk_jpeg_open':
> drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:8: error: implicit declaration of function 'kzalloc';did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
> 
> Including the header with the declaration solves the problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index b10183f7942b..f9bd58ce7d32 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-mem2mem.h>
