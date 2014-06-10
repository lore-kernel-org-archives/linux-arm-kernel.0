From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 15:52:41 +0200
Subject: [PATCH v3 2/6] ARM: EXYNOS: Remove i2c sys configuration related
 code
In-Reply-To: <1399706419-13976-3-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53970DA9.1060904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 10.05.2014 09:20, Pankaj Dubey wrote:
> Since all these code has been moved into i2c driver, now we can
> safely remove them from machine files.
> 
> CC: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c           |   38 +------------------------------
>  arch/arm/mach-exynos/include/mach/map.h |    3 ---
>  arch/arm/mach-exynos/pm.c               |   10 --------
>  arch/arm/mach-exynos/regs-sys.h         |   22 ------------------
>  4 files changed, 1 insertion(+), 72 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/regs-sys.h
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 59eb1f1..09063ee 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -29,11 +29,11 @@
>  #include <asm/memory.h>
>  
>  #include <plat/cpu.h>
> +#include <mach/map.h>
>  
>  #include "common.h"
>  #include "mfc.h"
>  #include "regs-pmu.h"
> -#include "regs-sys.h"
>  
>  #define L2_AUX_VAL 0x7C470001
>  #define L2_AUX_MASK 0xC200ffff
> @@ -42,11 +42,6 @@ static struct regmap *exynos_pmu_regmap;
>  
>  static struct map_desc exynos4_iodesc[] __initdata = {
>  	{
> -		.virtual	= (unsigned long)S3C_VA_SYS,
> -		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSCON),
> -		.length		= SZ_64K,
> -		.type		= MT_DEVICE,

Rest of this patch doesn't touch anything related to Exynos4, but I
boot-tested removing this on Exynos4412-based Trats2 board and it works, so

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
