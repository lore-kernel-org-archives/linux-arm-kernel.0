From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Oct 2011 20:31:03 +0900
Subject: [PATCH] ARM: SAMSUNG: s3c-dma-ops needs export.h for EXPORT_SYMBOL
In-Reply-To: <1317961214.16109.1.camel@phoenix>
References: <1317961214.16109.1.camel@phoenix>
Message-ID: <056b01cc8809$424a23a0$c6de6ae0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin wrote:
> 
> Fix below build warning:
>   CC      arch/arm/plat-samsung/s3c-dma-ops.o
> arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: data definition has no type or
> storage class
> arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: type defaults to 'int' in
> declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: parameter names (without
> types) in function declaration
> 
> And fix the build error:
> ERROR: "s3c_dma_get_ops" [drivers/spi/spi-s3c64xx.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> This can be reproduced by "make s3c6400_defconfig;make" on linux-next
> 20111006.
>  arch/arm/plat-samsung/s3c-dma-ops.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-
> dma-ops.c
> index 582333c..7814949 100644
> --- a/arch/arm/plat-samsung/s3c-dma-ops.c
> +++ b/arch/arm/plat-samsung/s3c-dma-ops.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/export.h>
> 
>  #include <mach/dma.h>
> 
> --
> 1.7.4.1
> 
OK, will apply.

BTW, I don't know why the build error/warning was not happened in my tree with s3c6400_defconfig. Probably other file having it?...

Anyway, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
