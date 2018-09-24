From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 24 Sep 2018 16:02:13 -0700
Subject: [PATCH] staging: vc04_services: Update TODO re: arm64
In-Reply-To: <20180924224835.32539-1-qader.aymen@gmail.com>
References: <20180924224835.32539-1-qader.aymen@gmail.com>
Message-ID: <bd51e861-41a6-6cad-c8aa-d56b13aa45c8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aymen


On 18-09-24 03:48 PM, Aymen Qader wrote:
> This patch removes the TODO item to remove manual cache flushing from b
Remove the use of "This patch".
Please read 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
"Describe your changes in imperative mood"

Also, it looks like you broke "bulk_receive" across 2 lines.
Please correct and fix receive typo.
> ulk_receieve - this was done in 7e8dbea. Also remove the unnecessary
also read in the guidelines:
If you want to refer to a specific commit, don't just refer to the SHA-1 
ID of the commit.
Please also include the oneline summary of the commit, to make it easier 
for reviewers to know what it is about.
> asm/cacheflush.h header.
>
> Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
> ---
>   drivers/staging/vc04_services/bcm2835-camera/TODO         | 6 ------
>   drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 1 -
>   2 files changed, 7 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/TODO b/drivers/staging/vc04_services/bcm2835-camera/TODO
> index cefce72d814f..6c2b4ffe4996 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/TODO
> +++ b/drivers/staging/vc04_services/bcm2835-camera/TODO
> @@ -15,9 +15,3 @@ padding in the V4L2 spec, but that padding doesn't match what the
>   hardware can do.  If we exposed the native padding requirements
>   through the V4L2 "multiplanar" formats, the firmware would have one
>   less copy it needed to do.
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
>   #include <linux/slab.h>
>   #include <linux/completion.h>
>   #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>   #include <media/videobuf2-vmalloc.h>
>   
>   #include "mmal-common.h"
