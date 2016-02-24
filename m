From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 24 Feb 2016 18:28:59 +0100
Subject: [PATCH 08/50] pinctrl: berlin: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-9-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-9-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160224172859.GB29884@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 24, 2016 at 06:45:33PM +0530, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Thanks!

Antoine

> Cc: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  drivers/pinctrl/berlin/berlin.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index 46f2b48..2d58166 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -316,7 +316,8 @@ int berlin_pinctrl_probe_regmap(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	pctrl->pctrl_dev = pinctrl_register(&berlin_pctrl_desc, dev, pctrl);
> +	pctrl->pctrl_dev = devm_pinctrl_register(dev, &berlin_pctrl_desc,
> +						 pctrl);
>  	if (IS_ERR(pctrl->pctrl_dev)) {
>  		dev_err(dev, "failed to register pinctrl driver\n");
>  		return PTR_ERR(pctrl->pctrl_dev);
> -- 
> 2.1.4
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/88b78011/attachment-0001.sig>
