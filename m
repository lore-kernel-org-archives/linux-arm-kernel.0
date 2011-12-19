From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 19 Dec 2011 20:02:29 +0000
Subject: [PATCH v6 01/11] davinci: vpif: remove obsolete header file
 inclusion
In-Reply-To: <1323951120-15876-2-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-2-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B604F83C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

In the subject line, calling mach/dm646x.h obsolete
is not right since as of this patch mach/dm646x.h
still exists.

On Thu, Dec 15, 2011 at 17:41:50, Hadli, Manjunath wrote:
> remove inclusion of header files from vpif.h and vpif_dispaly.c
> and add appropriate header file for building.

The main purpose of the patch is to remove machine specific
includes from driver files since that (among other things)
comes in the way of platform code consolidation. This needs
to come out in the description. Right now the description is
just describing the change without answering the question - why?

> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Cc: LMML <linux-media@vger.kernel.org>
> ---
>  drivers/media/video/davinci/vpif.h         |    2 +-
>  drivers/media/video/davinci/vpif_display.c |    2 --
>  2 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/video/davinci/vpif.h b/drivers/media/video/davinci/vpif.h
> index 25036cb..c96268a 100644
> --- a/drivers/media/video/davinci/vpif.h
> +++ b/drivers/media/video/davinci/vpif.h
> @@ -19,7 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/videodev2.h>
>  #include <mach/hardware.h>

It appears mach/hardware.h can be removed as well. Can you please
check?

> -#include <mach/dm646x.h>
> +#include <linux/i2c.h>

I2C is actually needed by include/media/davinci/vpif_types.h so it
should go there.

Thanks,
Sekhar
