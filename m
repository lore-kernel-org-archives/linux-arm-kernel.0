From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 30 Jul 2018 17:06:22 +0200
Subject: [PATCH] mmc: sunxi: allow 3.3V DDR when DDR is available
In-Reply-To: <20180722125407.43107-1-icenowy@aosc.io>
References: <20180722125407.43107-1-icenowy@aosc.io>
Message-ID: <CAPDyKFopeCwOO0jVet8EG6hkiVROfZH=TUv57qWkoL6BeM9qSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2018 at 14:54, Icenowy Zheng <icenowy@aosc.io> wrote:
> Some Allwinner boards feature an on-board eMMC with fixed 3.3V voltage
> (e.g. Banana Pi M2+), and in this case both the eMMC and the SoC are
> capable of doing 3.3V DDR transmission.
>
> Add capability of 3.3V DDR when DDR is available (extra clock or new
> timing).
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..4ea8e2611079 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1388,7 +1388,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>                                   MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
>         if (host->cfg->clk_delays || host->use_new_timings)
> -               mmc->caps      |= MMC_CAP_1_8V_DDR;
> +               mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
