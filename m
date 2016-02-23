From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 23 Feb 2016 09:09:17 +0900
Subject: [PATCH 3/3] ARM: EXYNOS: cleanup header files inclusion
In-Reply-To: <1456135396-17767-4-git-send-email-pankaj.dubey@samsung.com>
References: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
 <1456135396-17767-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56CBA32D.4020905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.02.2016 19:03, Pankaj Dubey wrote:
> This includes trivial cleanup in exynos files such as
>     - remove unused header files inclusion from exynos.c, s5p-dev-mfc.c,
>       firmware.c, pm.c.
>     - move inclusion of of.h from common.h to pm.c where it is really
>       required
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h      | 1 -
>  arch/arm/mach-exynos/exynos.c      | 5 -----
>  arch/arm/mach-exynos/firmware.c    | 2 --
>  arch/arm/mach-exynos/platsmp.c     | 1 -
>  arch/arm/mach-exynos/pm.c          | 4 +---
>  arch/arm/mach-exynos/s5p-dev-mfc.c | 1 -
>  6 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index e349a03..5365bf1 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -12,7 +12,6 @@
>  #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
>  #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
>  
> -#include <linux/of.h>
>  #include <linux/platform_data/cpuidle-exynos.h>
>  
>  #define EXYNOS3250_SOC_ID	0xE3472000
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 99947ad..54262a1 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -11,14 +11,10 @@
>  
>  #include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/serial_s3c.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> -#include <linux/platform_device.h>

platform_device is actually used in that file. It looks unused because
it is pulled by of_platform, but it makes sense to include it here.

Rest looks good.

BR,
Krzysztof
