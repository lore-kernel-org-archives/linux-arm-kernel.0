From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 06 Jul 2011 16:12:54 +0900
Subject: [PATCH] ARM: EXYNOS4: Set appropriate I2C device variant
In-Reply-To: <1309357573-13632-1-git-send-email-s.nawrocki@samsung.com>
References: <1309357573-13632-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <00ce01cc3bac$22844810$678cd830$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Set up a correct I2C bus controller variant name for Exynos4.
> Without this change the I2C bus driver fails to acquire its
> clocks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> This change is required to enable the I2C bus controller driver
> operation on exynos4 with the clkdev patches applied.
> 
> Regards,
> Sylwester
> ---
>  arch/arm/mach-exynos4/cpu.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index 1196f39..67918c0 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -23,6 +23,7 @@
>  #include <plat/sdhci.h>
>  #include <plat/devs.h>
>  #include <plat/fimc-core.h>
> +#include <plat/iic-core.h>
> 
>  #include <mach/regs-irq.h>
> 
> @@ -137,6 +138,11 @@ void __init exynos4_map_io(void)
>  	s3c_fimc_setname(1, "exynos4-fimc");
>  	s3c_fimc_setname(2, "exynos4-fimc");
>  	s3c_fimc_setname(3, "exynos4-fimc");
> +
> +	/* The I2C bus controllers are directly compatible with s3c2440 */
> +	s3c_i2c0_setname("s3c2440-i2c");
> +	s3c_i2c1_setname("s3c2440-i2c");
> +	s3c_i2c2_setname("s3c2440-i2c");
>  }
> 
>  void __init exynos4_init_clocks(int xtal)
> --
> 1.7.2.5

Right, will apply into -fix tree.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
