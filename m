From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sat, 01 Jun 2013 17:30:17 +0200
Subject: [PATCH 13/15] [media] omap3isp: include linux/mm_types.h
In-Reply-To: <1370038972-2318779-14-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <1370038972-2318779-14-git-send-email-arnd@arndb.de>
Message-ID: <3507557.BiLMFItQuE@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thank you for the patch.

On Saturday 01 June 2013 00:22:50 Arnd Bergmann wrote:
> The ispqueue.h file uses vm_flags_t, which is defined in
> linux/mm_types.h, so we must include that header in order
> to build in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: linux-media at vger.kernel.org
> Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

(with a minor nitpick below)

> ---
>  drivers/media/platform/omap3isp/ispqueue.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/omap3isp/ispqueue.h
> b/drivers/media/platform/omap3isp/ispqueue.h index 908dfd7..e6e720c 100644
> --- a/drivers/media/platform/omap3isp/ispqueue.h
> +++ b/drivers/media/platform/omap3isp/ispqueue.h
> @@ -31,6 +31,7 @@
>  #include <linux/mutex.h>
>  #include <linux/videodev2.h>
>  #include <linux/wait.h>
> +#include <linux/mm_types.h>

Could you please make sure the headers are sorted alphabetically ?

Would you like me to take the patch in my tree ? If so I'll sort the headers 
myself.

>  struct isp_video_queue;
>  struct page;

-- 
Regards,

Laurent Pinchart
