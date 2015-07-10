From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Jul 2015 09:15:24 +0200
Subject: [PATCH] soc: mediatek: Drop owner assignment from platform_driver
In-Reply-To: <1436509789-27361-1-git-send-email-k.kozlowski@samsung.com>
References: <1436509789-27361-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150710071524.GW18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 03:29:45PM +0900, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
> ---
> 
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index f432291feee9..8bc7b41b09fd 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -926,7 +926,6 @@ err_out1:
>  static struct platform_driver pwrap_drv = {
>  	.driver = {
>  		.name = "mt-pmic-pwrap",
> -		.owner = THIS_MODULE,
>  		.of_match_table = of_match_ptr(of_pwrap_match_tbl),
>  	},
>  	.probe = pwrap_probe,
> -- 
> 1.9.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
