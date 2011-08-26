From: khilman@ti.com (Kevin Hilman)
Date: Fri, 26 Aug 2011 16:06:29 -0700
Subject: [PATCHv6 1/3] OMAP: I2C: Reset support
In-Reply-To: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Fri, 5 Aug 2011 11:30:33 +0530")
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87bovbzsay.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Needs update/rebase to apply against my for_3.2/i2c-cleanup branch...

[...]

> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
> index 98ae49b..8aa91b6 100644
> --- a/include/linux/i2c-omap.h
> +++ b/include/linux/i2c-omap.h
> @@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
>  	int		(*device_enable) (struct platform_device *pdev);
>  	int		(*device_shutdown) (struct platform_device *pdev);
>  	int		(*device_idle) (struct platform_device *pdev);

The above functions no longer exist in the platform_data struct.

> +	int		(*device_reset) (struct device *dev);
>  };
>  
>  #endif

Kevin
