From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 01 Dec 2011 19:29:24 +0900
Subject: [RESEND][PATCH] ARM: EXYNOS: Fixed undefined symbol compilation
 error.
In-Reply-To: <1321352102-10021-1-git-send-email-pankaj.dubey@samsung.com>
References: <1321352102-10021-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <047101ccb014$18766ab0$49634010$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dubey wrote:
> 
> Many drivers will fail to compile if compiled as module due to
> undefined symbol exynos4_ioremap.
> Fix has been added by exporting the same in cpu.c file.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/cpu.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
> index 8e09f34..027f65471 100644
> --- a/arch/arm/mach-exynos/cpu.c
> +++ b/arch/arm/mach-exynos/cpu.c
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> +#include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/sysdev.h>
>  #include <linux/of.h>
> @@ -164,6 +165,7 @@ void __iomem *exynos4_ioremap(unsigned long phy,
> size_t size, unsigned int type)
> 
>  	return __arm_ioremap(phy, size, type);
>  }
> +EXPORT_SYMBOL(exynos4_ioremap);
> 
>  static void exynos_idle(void)
>  {
> --
> 1.7.4.1

Hi Pankaj,

As we discussed internally, since Nicolas Pitre's vmalloc patch series this
can be dropped.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
