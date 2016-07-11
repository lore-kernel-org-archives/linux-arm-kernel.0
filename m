From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jul 2016 10:02:23 +0100
Subject: [PATCH 5/7] bus: vexpress-config: add missing of_node_put after
 calling of_parse_phandle
In-Reply-To: <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
Message-ID: <20160711090223.GJ8609@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 05:41:59PM +0800, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> ---
>  drivers/bus/vexpress-config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index c3cb76b..9efdf1d 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -178,6 +178,7 @@ static int vexpress_config_populate(struct device_node *node)
>  
>  	parent = class_find_device(vexpress_config_class, NULL, bridge,
>  			vexpress_config_node_match);
> +	of_node_put(bridge);
>  	if (WARN_ON(!parent))
>  		return -ENODEV;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
