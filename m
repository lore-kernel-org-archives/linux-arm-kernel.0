From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 9 Nov 2017 17:28:06 +0100
Subject: [PATCH v2 5/7] clocksource: dmtimer: Populate the timer ops to
 the pdata
In-Reply-To: <1510144108-29563-6-git-send-email-j-keerthy@ti.com>
References: <1510144108-29563-1-git-send-email-j-keerthy@ti.com>
 <1510144108-29563-6-git-send-email-j-keerthy@ti.com>
Message-ID: <20171109162806.xyzrqxnldailqzai@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 08, 2017 at 05:58:26PM +0530, Keerthy wrote:
> Add the timer ops to the platform data
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> No code changes in this v2 version. Only enhanced patch
> statistics for renames.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/clocksource/dmtimer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clocksource/dmtimer.c b/drivers/clocksource/dmtimer.c
> index afe1dc9..1cbd954 100644
> --- a/drivers/clocksource/dmtimer.c
> +++ b/drivers/clocksource/dmtimer.c
> @@ -922,8 +922,33 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static struct omap_dm_timer_ops dmtimer_ops = {
> +	.request_by_node = omap_dm_timer_request_by_node,
> +	.request_specific = omap_dm_timer_request_specific,
> +	.request = omap_dm_timer_request,
> +	.set_source = omap_dm_timer_set_source,
> +	.get_irq = omap_dm_timer_get_irq,
> +	.set_int_enable = omap_dm_timer_set_int_enable,
> +	.set_int_disable = omap_dm_timer_set_int_disable,
> +	.free = omap_dm_timer_free,
> +	.enable = omap_dm_timer_enable,
> +	.disable = omap_dm_timer_disable,
> +	.get_fclk = omap_dm_timer_get_fclk,
> +	.start = omap_dm_timer_start,
> +	.stop = omap_dm_timer_stop,
> +	.set_load = omap_dm_timer_set_load,
> +	.set_match = omap_dm_timer_set_match,
> +	.set_pwm = omap_dm_timer_set_pwm,
> +	.set_prescaler = omap_dm_timer_set_prescaler,
> +	.read_counter = omap_dm_timer_read_counter,
> +	.write_counter = omap_dm_timer_write_counter,
> +	.read_status = omap_dm_timer_read_status,
> +	.write_status = omap_dm_timer_write_status,
> +};
> +
>  static const struct dmtimer_platform_data omap3plus_pdata = {
>  	.timer_errata = OMAP_TIMER_ERRATA_I103_I767,
> +	.timer_ops = &dmtimer_ops,
>  };
>  
>  static const struct of_device_id omap_timer_match[] = {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171109/0279db09/attachment.sig>
