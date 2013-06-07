From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 07 Jun 2013 15:20:55 -0700
Subject: [PATCH] ARM: OMAP2+: Fix serial init for device tree based booting
In-Reply-To: <20130607215503.GK3331@atomide.com> (Tony Lindgren's message of
 "Fri, 7 Jun 2013 14:55:04 -0700")
References: <20130607215503.GK3331@atomide.com>
Message-ID: <87fvwtlfzs.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> We don't want to call omap_serial_early_init() for device
> tree based booting as the ports are initialized based on
> the .dts entries.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Kevin Hilman <khilman@linaro.org>


> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -176,6 +176,9 @@ static char *cmdline_find_option(char *str)
>  
>  static int __init omap_serial_early_init(void)
>  {
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>  	do {
>  		char oh_name[MAX_UART_HWMOD_NAME_LEN];
>  		struct omap_hwmod *oh;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
