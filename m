From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 18 Dec 2013 15:12:42 +0900
Subject: [PATCH 11/11] PM / devfreq: use inclusion <mach/map.h> instead of
 <plat/map-s5p.h>
In-Reply-To: <116901cefb1e$90f4b530$b2de1f90$@kernel.org>
References: <116901cefb1e$90f4b530$b2de1f90$@kernel.org>
Message-ID: <CAJ0PZbQnm3on8UisiRwGQ2OnE1G8PsKdpofEqv-RgePdG31qLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 8:53 PM,  <kgene@kernel.org> wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
>
> This fixes follwoing warning:
> In file included from drivers/devfreq/exynos/exynos4_bus.h:15:0,
>                  from drivers/devfreq/exynos/exynos4_bus.c:35:
> arch/arm/mach-exynos/include/mach/map.h:22:0: warning: "S3C_UART_OFFSET"
> redefined [enabled by default]
> In file included from drivers/devfreq/exynos/exynos4_bus.c:33:0:
> arch/arm/plat-samsung/include/plat/map-s5p.h:57:0: note: this is the
> location of the previous definition
>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks!

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>



Cheers,
MyungJoo.

> ---
>  drivers/devfreq/exynos/exynos4_bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/exynos/exynos4_bus.c
> b/drivers/devfreq/exynos/exynos4_bus.c
> index 16eb406..1ab8cdd 100644
> --- a/drivers/devfreq/exynos/exynos4_bus.c
> +++ b/drivers/devfreq/exynos/exynos4_bus.c
> @@ -30,7 +30,7 @@
>  extern unsigned int exynos_result_of_asv;
>  #endif
>
> -#include <plat/map-s5p.h>
> +#include <mach/map.h>
>
>  #include "exynos4_bus.h"
>
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
System S/W Lab, S/W Center, Samsung Electronics
