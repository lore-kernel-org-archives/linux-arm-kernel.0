From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 4 Mar 2015 14:32:45 +0100
Subject: [PATCH] pinctrl: at91: simplify probe error handling
In-Reply-To: <2adab2d9a86d0e44051541052ace08527bdcc045.1425317325.git.baruch@tkos.co.il>
References: <2adab2d9a86d0e44051541052ace08527bdcc045.1425317325.git.baruch@tkos.co.il>
Message-ID: <20150304133245.GF9132@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 07:28:45PM +0200, Baruch Siach wrote:
> There is no code ender the 'err' label. Just return the error code directly.
>

Probably a remainder of pre managed resources time.

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/pinctrl/pinctrl-at91.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index f4cd0b9b2438..6cfe534ab27e 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1240,8 +1240,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
>  
>  	if (!info->pctl) {
>  		dev_err(&pdev->dev, "could not register AT91 pinctrl driver\n");
> -		ret = -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
>  
>  	/* We will handle a range of GPIO pins */
> @@ -1252,9 +1251,6 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
>  
>  	return 0;
> -
> -err:
> -	return ret;
>  }
>  
>  static int at91_pinctrl_remove(struct platform_device *pdev)
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
