From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 30 Nov 2016 19:05:11 +0800
Subject: [PATCH v10 09/13] drm/mediatek: add mipi_tx data rate check
In-Reply-To: <1480070076-6196-10-git-send-email-yt.shen@mediatek.com>
References: <1480070076-6196-1-git-send-email-yt.shen@mediatek.com>
 <1480070076-6196-10-git-send-email-yt.shen@mediatek.com>
Message-ID: <1480503911.13978.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, YT:


On Fri, 2016-11-25 at 18:34 +0800, YT Shen wrote:
> modify data rate limitation (>lGbps/lane) for mipitx
> 

I think MT2701 DRM can work correctly without this patch.
Why do you put this patch in MT2701 series?
Maybe you can send this patch independently.

Regards,
CK

> Signed-off-by: shaoming chen <shaoming.chen@mediatek.com>
> Signed-off-by: YT Shen <yt.shen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> index fd84914..1ef00ac 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -177,7 +177,9 @@ static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
>  
>  	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
>  
> -	if (mipi_tx->data_rate >= 500000000) {
> +	if (mipi_tx->data_rate > 1250000000) {
> +		return -EINVAL;
> +	} else if (mipi_tx->data_rate >= 500000000) {
>  		txdiv = 1;
>  		txdiv0 = 0;
>  		txdiv1 = 0;
