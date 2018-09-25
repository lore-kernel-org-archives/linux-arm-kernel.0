From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 25 Sep 2018 09:12:25 +0200
Subject: [PATCH v2] staging: vc04_services: Update TODO re: arm64
In-Reply-To: <20180924233426.32609-1-qader.aymen@gmail.com>
References: <20180924224835.32539-1-qader.aymen@gmail.com>
 <20180924233426.32609-1-qader.aymen@gmail.com>
Message-ID: <34086ca9-758f-5228-2acb-04915c2e148d@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Aymen,

there are more than one TODO file in vc04_services (contains 3 drivers),
so here is my suggestion for the subject:

staging: bcm2835-camera: Update TODO

Am 25.09.2018 um 01:34 schrieb Aymen Qader:
> Remove the TODO item to remove manual cache flushing from bulk_receive.
> This was previously done in this commit:
>
> (7e8dbdea) staging: bcm2835-camera: Remove explicit cache flush
> operations

please use this format, which should also make scripts/checkpatch.pl happy:

commit 7e8dbea41032 ("staging: bcm2835-camera: Remove explicit cache
flush operations ")

>
> Also remove the unnecessary asm/cacheflush.h header.

This doesn't match to the subject. Maybe a separate patch would be
better here.

Thanks
Stefan

>
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
> v2: Make commit message clearer
>
>  drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>  drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
> index cefce72d814f..6c2b4ffe4996 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/TODO
> +++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
> @@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
>  hardware can do.  If we exposed the native padding requirements
>  through the V4L2 "multiplanar" formats, the firmware would have one
>  less copy it needed to do.
> -
> -3) Port to ARM64
> -
> -The bulk_receive() does some manual cache flushing that are 32-bit ARM
> -only, which we should convert to proper cross-platform APIs.
> -
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> index 51e5b04ff0f5..6e5c1d4ee122 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> @@ -21,7 +21,6 @@
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>  #include <media/videobuf2-vmalloc.h>
>  
>  #include "mmal-common.h"
