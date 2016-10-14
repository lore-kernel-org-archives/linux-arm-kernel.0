From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 14 Oct 2016 17:27:30 +0200
Subject: [PATCH 2/3] thermal: tango: Fix module autoload
In-Reply-To: <1476455702-21748-3-git-send-email-javier@osg.samsung.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
 <1476455702-21748-3-git-send-email-javier@osg.samsung.com>
Message-ID: <5800F962.8040605@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2016 16:35, Javier Martinez Canillas wrote:

> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/thermal/tango_thermal.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/thermal/tango_thermal.ko | grep alias
> alias:          of:N*T*Csigma,smp8758-thermalC*
> alias:          of:N*T*Csigma,smp8758-thermal
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/thermal/tango_thermal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
> index 201304aeafeb..4e67795cb6ce 100644
> --- a/drivers/thermal/tango_thermal.c
> +++ b/drivers/thermal/tango_thermal.c
> @@ -107,6 +107,7 @@ static const struct of_device_id tango_sensor_ids[] = {
>  	},
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, tango_sensor_ids);

Thanks for fixing it :-)

Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Regards.
