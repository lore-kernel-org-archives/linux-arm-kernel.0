From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Feb 2013 14:57:50 -0800
Subject: [PATCH 9/9] [media] davinci: do not include mach/hardware.h
In-Reply-To: <1360882071-4072668-10-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-10-git-send-email-arnd@arndb.de>
Message-ID: <20130214225749.GJ11362@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130214 14:51]:
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

All mach and plat includes from drivers should be fixed
and removed as that adds nasty dependencies between core SoC
code and the drivers.

Acked-by: Tony Lindgren <tony@atomide.com>

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
