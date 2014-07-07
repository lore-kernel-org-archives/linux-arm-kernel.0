From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 03:51:02 -0700
Subject: [PATCH v2] ARM: OMAP2+: Make GPMC skip disabled devices
In-Reply-To: <1404308118-14843-1-git-send-email-guido@vanguardiasur.com.ar>
References: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
 <1404308118-14843-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <20140707105101.GN28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Guido Mart?nez <guido@vanguardiasur.com.ar> [140702 06:34]:
> Currently, child nodes of the gpmc node are iterated and probed
> regardless of their 'status' property. This means adding 'status =
> "disabled";' has no effect.
> 
> This patch changes the iteration to only probe nodes marked as
> available.
> 
> Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
> ---
> v2: Make patch title consistent with previous gpmc patches

Thanks applying into omap-for-v3.16/fixes.

Tony
 
>  arch/arm/mach-omap2/gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 2c0c281..8bc1338 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1615,7 +1615,7 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	for_each_child_of_node(pdev->dev.of_node, child) {
> +	for_each_available_child_of_node(pdev->dev.of_node, child) {
>  
>  		if (!child->name)
>  			continue;
> -- 
> 2.0.0
> 
