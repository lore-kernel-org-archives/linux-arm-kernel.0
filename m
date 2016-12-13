From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Tue, 13 Dec 2016 17:38:44 +0800
Subject: [PATCH v1 2/3] clk: rockchip: add clock controller for rk3328
In-Reply-To: <1481618869-1239-3-git-send-email-zhangqing@rock-chips.com>
References: <1481618869-1239-1-git-send-email-zhangqing@rock-chips.com>
 <1481618869-1239-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <acc7fa12-07ee-eab0-c8e8-b8bba00d9b00@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Elaine,

I always only keep an eye for mmc stuff here. :)

On 2016/12/13 16:47, Elaine Zhang wrote:
> Add the clock tree definition for the new rk3328 SoC.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

----8<--------------

> +
> +	/* PD_MMC */
> +	MMC(SCLK_SDMMC_DRV, "sdmmc_drv", "sclk_sdmmc",
> +	    RK3328_SDMMC_CON0, 1),
> +	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "sclk_sdmmc",
> +	    RK3328_SDMMC_CON1, 0),
> +

All of offset for these *_sample are wrong, and they should be 1
, the same as *_drv. You could refer to P565 of TRM instead the
section of CRU for these details.

> +	MMC(SCLK_SDIO_DRV, "sdio_drv", "sclk_sdio",
> +	    RK3328_SDIO_CON0, 1),
> +	MMC(SCLK_SDIO_SAMPLE, "sdio_sample", "sclk_sdio",
> +	    RK3328_SDIO_CON1, 0),
> +
> +	MMC(SCLK_EMMC_DRV, "emmc_drv", "sclk_emmc",
> +	    RK3328_EMMC_CON0, 1),
> +	MMC(SCLK_EMMC_SAMPLE, "emmc_sample", "sclk_emmc",
> +	    RK3328_EMMC_CON1, 0),
> +
> +	MMC(SCLK_SDMMC_EXT_DRV, "sdmmc_ext_drv", "sclk_sdmmc_ext",
> +	    RK3328_SDMMC_EXT_CON0, 1),
> +	MMC(SCLK_SDMMC_EXT_SAMPLE, "sdmmc_ext_sample", "sclk_sdmmc_ext",
> +	    RK3328_SDMMC_EXT_CON1, 0),
> +};
> +

----8<--------


> +#define RK3328_SDMMC_CON0		0x380
> +#define RK3328_SDMMC_CON1		0x384
> +#define RK3328_SDIO_CON0		0x388
> +#define RK3328_SDIO_CON1		0x38c
> +#define RK3328_EMMC_CON0		0x390
> +#define RK3328_EMMC_CON1		0x394
> +#define RK3328_SDMMC_EXT_CON0		0x398
> +#define RK3328_SDMMC_EXT_CON1		0x39C


Just wondering is it worth, but this uppercase 'C' isn't
consistent with the former lowercase


> +
>  #define RK3368_PLL_CON(x)		RK2928_PLL_CON(x)
>  #define RK3368_CLKSEL_CON(x)		((x) * 0x4 + 0x100)
>  #define RK3368_CLKGATE_CON(x)		((x) * 0x4 + 0x200)
> @@ -130,6 +152,7 @@
>  enum rockchip_pll_type {
>  	pll_rk3036,
>  	pll_rk3066,
> +	pll_rk3328,
>  	pll_rk3399,
>  };
>
>


-- 
Best Regards
Shawn Lin
