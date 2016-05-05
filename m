From: briannorris@chromium.org (Brian Norris)
Date: Thu, 5 May 2016 09:37:48 -0700
Subject: [PATCH] clk: rockchip: fix the rk3399 sdmmc sample / drv name
In-Reply-To: <1462404985-27957-1-git-send-email-dianders@chromium.org>
References: <1462404985-27957-1-git-send-email-dianders@chromium.org>
Message-ID: <20160505163748.GA97052@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 04:36:25PM -0700, Douglas Anderson wrote:
> The rk3399 clock table had a simple typo in it, calling the SDMMC sample
> and drive clocks by the wrong name.  Fix this minor typo.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

LGTM.

Tested-by: Brian Norris <briannorris@chromium.org>
Acked-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/clk/rockchip/clk-rk3399.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 5248726af86d..291543f52caa 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -894,8 +894,8 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>  			RK3399_CLKSEL_CON(16), 8, 3, MFLAGS, 0, 7, DFLAGS,
>  			RK3399_CLKGATE_CON(6), 1, GFLAGS),
>  
> -	MMC(SCLK_SDMMC_DRV,     "emmc_drv",    "clk_sdmmc", RK3399_SDMMC_CON0, 1),
> -	MMC(SCLK_SDMMC_SAMPLE,  "emmc_sample", "clk_sdmmc", RK3399_SDMMC_CON1, 1),
> +	MMC(SCLK_SDMMC_DRV,     "sdmmc_drv",    "clk_sdmmc", RK3399_SDMMC_CON0, 1),
> +	MMC(SCLK_SDMMC_SAMPLE,  "sdmmc_sample", "clk_sdmmc", RK3399_SDMMC_CON1, 1),
>  
>  	MMC(SCLK_SDIO_DRV,      "sdio_drv",    "clk_sdio",  RK3399_SDIO_CON0,  1),
>  	MMC(SCLK_SDIO_SAMPLE,   "sdio_sample", "clk_sdio",  RK3399_SDIO_CON1,  1),
> -- 
> 2.8.0.rc3.226.g39d4020
