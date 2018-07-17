From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 17 Jul 2018 19:45:42 +0530
Subject: [PATCH v6 1/5] clk: actions: Add missing REGMAP_MMIO dependency
In-Reply-To: <20180715203524.11948-2-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-2-sravanhome@gmail.com>
Message-ID: <20180717141542.GD19076@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 10:35:20PM +0200, Saravanan Sekar wrote:
> Add REGMAP_MMIO as dependency to avoid undefined
> reference to regmap symbols.
> 
> Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/clk/actions/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> index 8854adb37847..39491154abbf 100644
> --- a/drivers/clk/actions/Kconfig
> +++ b/drivers/clk/actions/Kconfig
> @@ -1,6 +1,7 @@
>  config CLK_ACTIONS
>  	bool "Clock driver for Actions Semi SoCs"
>  	depends on ARCH_ACTIONS || COMPILE_TEST
> +	select REGMAP_MMIO
>  	default ARCH_ACTIONS
>  
>  if CLK_ACTIONS
> -- 
> 2.18.0
> 
