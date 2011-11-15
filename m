From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 15 Nov 2011 14:54:49 +0400
Subject: [PATCH v2 5/5] davinci: delete individual platform header files
 and use a common header
In-Reply-To: <1321283357-27698-6-git-send-email-manjunath.hadli@ti.com>
References: <1321283357-27698-1-git-send-email-manjunath.hadli@ti.com>
 <1321283357-27698-6-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EC244F9.1030604@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-11-2011 19:09, Manjunath Hadli wrote:

> include davinci_common.h file in files using the platform
> header file for dm355, dm365, dm644x and dm646x and delete the
> individual platform header files.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
[...]

> diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
> index 25036cb..73b00bd 100644
> --- a/drivers/media/video/davinci/vpif.h
> +++ b/drivers/media/video/davinci/vpif.h
> @@ -18,8 +18,7 @@
>
>   #include<linux/io.h>
>   #include<linux/videodev2.h>
> -#include<mach/hardware.h>

    Why are you removing this?

> -#include<mach/dm646x.h>
> +#include<mach/davinci_common.h>
>   #include<media/davinci/vpif_types.h>
>
>   /* Maximum channel allowed */
> diff --git a/drivers/media/video/davinci/vpif_capture.h b/drivers/media/video/davinci/vpif_capture.h
> index a693d4e..c019d26 100644
> --- a/drivers/media/video/davinci/vpif_capture.h
> +++ b/drivers/media/video/davinci/vpif_capture.h
> @@ -27,6 +27,7 @@
>   #include<media/v4l2-device.h>
>   #include<media/videobuf-core.h>
>   #include<media/videobuf-dma-contig.h>
> +#include<mach/davinci_common.h>

    Not clear why are you adding this when no platform header was included before.

WBR, Sergei
