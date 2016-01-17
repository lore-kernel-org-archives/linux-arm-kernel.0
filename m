From: jcd@tribudubois.net (Jean-Christophe DUBOIS)
Date: Sun, 17 Jan 2016 18:53:05 +0100
Subject: [PATCH] [ARM] i.MX6: fix cleanup path in imx6q_suspend_init()
In-Reply-To: <1451168168-24303-1-git-send-email-jcd@tribudubois.net>
References: <1451168168-24303-1-git-send-email-jcd@tribudubois.net>
Message-ID: <569BD501.6040308@tribudubois.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, Sascha,

Are you OK with this patch?

JC

Le 26/12/2015 23:16, Jean-Christophe Dubois a ?crit :
> The wrong pointer is passed to the ioumap function in the cleanup path
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   arch/arm/mach-imx/pm-imx6.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> index 4470376..58924b3 100644
> --- a/arch/arm/mach-imx/pm-imx6.c
> +++ b/arch/arm/mach-imx/pm-imx6.c
> @@ -561,13 +561,13 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
>   	goto put_node;
>   
>   pl310_cache_map_failed:
> -	iounmap(&pm_info->gpc_base.vbase);
> +	iounmap(pm_info->gpc_base.vbase);
>   gpc_map_failed:
> -	iounmap(&pm_info->iomuxc_base.vbase);
> +	iounmap(pm_info->iomuxc_base.vbase);
>   iomuxc_map_failed:
> -	iounmap(&pm_info->src_base.vbase);
> +	iounmap(pm_info->src_base.vbase);
>   src_map_failed:
> -	iounmap(&pm_info->mmdc_base.vbase);
> +	iounmap(pm_info->mmdc_base.vbase);
>   put_node:
>   	of_node_put(node);
>   
