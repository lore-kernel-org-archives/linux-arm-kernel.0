From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Mar 2017 10:10:07 +0000
Subject: [PATCH v4 4/5] mfd: exynos-lpass: Use common
 soc/exynos-regs-pmu.h header
In-Reply-To: <20170314164653.15771-5-krzk@kernel.org>
References: <20170314164653.15771-1-krzk@kernel.org>
 <20170314164653.15771-5-krzk@kernel.org>
Message-ID: <20170315101007.xtnwz7mmkt446sgd@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Mar 2017, Krzysztof Kozlowski wrote:

> The MFD-specific header will go away because it duplicates defines from
> exynos-regs-pmu.h.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/mfd/exynos-lpass.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
> index 2e064fb8826f..8bebad92a385 100644
> --- a/drivers/mfd/exynos-lpass.c
> +++ b/drivers/mfd/exynos-lpass.c
> @@ -18,11 +18,11 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/mfd/syscon/exynos5-pmu.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/soc/samsung/exynos-regs-pmu.h>
>  #include <linux/types.h>
>  
>  /* LPASS Top register definitions */
> @@ -83,7 +83,7 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
>  
>  	/* Activate related PADs from retention state */
>  	regmap_write(lpass->pmu, EXYNOS5433_PAD_RETENTION_AUD_OPTION,
> -		     EXYNOS5433_PAD_INITIATE_WAKEUP_FROM_LOWPWR);
> +		     EXYNOS_WAKEUP_FROM_LOWPWR);
>  
>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
