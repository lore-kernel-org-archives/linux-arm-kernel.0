From: tiffany.lin@mediatek.com (tiffany lin)
Date: Tue, 12 Jul 2016 19:25:58 +0800
Subject: [PATCH -next] [media] mtk-vcodec: remove redundant dev_err call
 in mtk_vcodec_probe()
In-Reply-To: <1468321379-16133-1-git-send-email-weiyj_lk@163.com>
References: <1468321379-16133-1-git-send-email-weiyj_lk@163.com>
Message-ID: <1468322758.2462.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Tiffany Lin <tiffany.lin@mediatek.com>

On Tue, 2016-07-12 at 11:02 +0000, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> index 9c10cc2..b33a931 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> @@ -279,8 +279,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  		}
>  		dev->reg_base[i] = devm_ioremap_resource(&pdev->dev, res);
>  		if (IS_ERR((__force void *)dev->reg_base[i])) {
> -			dev_err(&pdev->dev,
> -				"devm_ioremap_resource %d failed.", i);
>  			ret = PTR_ERR((__force void *)dev->reg_base[i]);
>  			goto err_res;
>  		}
> 
> 
