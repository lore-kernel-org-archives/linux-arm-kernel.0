From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 15 Mar 2018 11:23:26 +0100
Subject: [PATCH] mmc: dw_mmc-rockchip: correct property names in debug
In-Reply-To: <20180301103625.7285-1-john@metanate.com>
References: <20180301103625.7285-1-john@metanate.com>
Message-ID: <CAPDyKFro5hvuEKuiPHCg9WEf7Ysmj_9GJ_bykquq9+okA2Sk_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2018 at 11:36, John Keeping <john@metanate.com> wrote:
> Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
> rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
> Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
> property name in the debug output if clocks are not found.
>
> Signed-off-by: John Keeping <john@metanate.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 339295212935..40d7de2eea12 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -282,11 +282,11 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>
>         priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
>         if (IS_ERR(priv->drv_clk))
> -               dev_dbg(host->dev, "ciu_drv not available\n");
> +               dev_dbg(host->dev, "ciu-drive not available\n");
>
>         priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
>         if (IS_ERR(priv->sample_clk))
> -               dev_dbg(host->dev, "ciu_sample not available\n");
> +               dev_dbg(host->dev, "ciu-sample not available\n");
>
>         host->priv = priv;
>
> --
> 2.16.2
>
