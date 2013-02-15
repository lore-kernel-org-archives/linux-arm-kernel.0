From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 15 Feb 2013 10:36:53 +0530
Subject: [PATCH 9/9] [media] davinci: do not include mach/hardware.h
In-Reply-To: <1360882071-4072668-10-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-10-git-send-email-arnd@arndb.de>
Message-ID: <CA+V-a8twXpuy3+ScdR26pwYn0LriKVqnwR5Qgyv_vtf4dgEyGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the patch.

On Fri, Feb 15, 2013 at 4:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> It is now possible to build the davinci vpss code
> on multiplatform kernels, which causes a problem
> since the driver tries to incude the davinci
> platform specific mach/hardware.h file. Fortunately
> that file is not required at all in the driver,
> so we can simply remove the #include statement.
>
> Without this patch, building allyesconfig results in:
>
> drivers/media/platform/davinci/vpss.c:28:27: fatal error: mach/hardware.h: No such file or directory
> compilation terminated.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: "Lad, Prabhakar" <prabhakar.lad@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Acked-by: Lad, Prabhakar <prabhakar.lad@ti.com>

Regards,
--Prabhakar

> ---
>  drivers/media/platform/davinci/vpss.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/platform/davinci/vpss.c b/drivers/media/platform/davinci/vpss.c
> index 494d322..a19c552 100644
> --- a/drivers/media/platform/davinci/vpss.c
> +++ b/drivers/media/platform/davinci/vpss.c
> @@ -25,7 +25,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/compiler.h>
>  #include <linux/io.h>
> -#include <mach/hardware.h>
>  #include <media/davinci/vpss.h>
>
>  MODULE_LICENSE("GPL");
> --
> 1.8.1.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
