From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 7 Oct 2012 11:12:27 +0800
Subject: [PATCH] mmc: mxs-mmc: Fix merge issue causing build error
In-Reply-To: <1349124763-10840-1-git-send-email-marex@denx.de>
References: <1349124763-10840-1-git-send-email-marex@denx.de>
Message-ID: <20121007031224.GK20231@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy Chris who should be able to help send this fix for 3.7-rc.

Shawn

On Mon, Oct 01, 2012 at 10:52:43PM +0200, Marek Vasut wrote:
> The following error appeared due to trivial merge problem:
> 
> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
> drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'base'
> drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'devid'
> make[3]: *** [drivers/mmc/host/mxs-mmc.o] Error 1
> 
> This patches corrects the issue.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index bb4c2bf..80d1e6d 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>  		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
> -		       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
> +		       ssp->base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_SET);
>  	} else {
>  		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
>  		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> -- 
> 1.7.10.4
> 
