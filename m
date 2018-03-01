From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Mar 2018 11:21:49 +0000
Subject: [PATCH] mmc: dw_mmc-rockchip: correct property names in debug
In-Reply-To: <20180301103625.7285-1-john@metanate.com>
References: <20180301103625.7285-1-john@metanate.com>
Message-ID: <e665dcdb-edd8-8802-e7f2-445b71cd6acd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/18 10:36, John Keeping wrote:
> Following up the device tree fixed in commits e78c637127ee ("ARM: dts:
> rockchip: Fix DWMMC clocks") and ca9eee95a2de ("arm64: dts: rockchip:
> Fix DWMMC clocks", 2018-02-15), avoid confusion by using the correct
> property name in the debug output if clocks are not found.

Yeah, I was lazy since this inconsistency was already present and I just 
wanted to make my thing work :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Keeping <john@metanate.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 339295212935..40d7de2eea12 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -282,11 +282,11 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>   
>   	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
>   	if (IS_ERR(priv->drv_clk))
> -		dev_dbg(host->dev, "ciu_drv not available\n");
> +		dev_dbg(host->dev, "ciu-drive not available\n");
>   
>   	priv->sample_clk = devm_clk_get(host->dev, "ciu-sample");
>   	if (IS_ERR(priv->sample_clk))
> -		dev_dbg(host->dev, "ciu_sample not available\n");
> +		dev_dbg(host->dev, "ciu-sample not available\n");
>   
>   	host->priv = priv;
>   
> 
