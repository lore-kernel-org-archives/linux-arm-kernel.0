From: blogic@openwrt.org (John Crispin)
Date: Thu, 25 Feb 2016 15:24:49 +0100
Subject: [PATCH 39/50] pinctrl: lantiq: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-40-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-40-git-send-email-ldewangan@nvidia.com>
Message-ID: <56CF0EB1.304@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/02/2016 14:16, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: John Crispin <blogic@openwrt.org>




> ---
>  drivers/pinctrl/pinctrl-lantiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-lantiq.c b/drivers/pinctrl/pinctrl-lantiq.c
> index fc38a85..a4d6474 100644
> --- a/drivers/pinctrl/pinctrl-lantiq.c
> +++ b/drivers/pinctrl/pinctrl-lantiq.c
> @@ -336,7 +336,7 @@ int ltq_pinctrl_register(struct platform_device *pdev,
>  	desc->pmxops = &ltq_pmx_ops;
>  	info->dev = &pdev->dev;
>  
> -	info->pctrl = pinctrl_register(desc, &pdev->dev, info);
> +	info->pctrl = devm_pinctrl_register(&pdev->dev, desc, info);
>  	if (IS_ERR(info->pctrl)) {
>  		dev_err(&pdev->dev, "failed to register LTQ pinmux driver\n");
>  		return PTR_ERR(info->pctrl);
> 
