From: jhovold@gmail.com (Johan Hovold)
Date: Fri, 29 Mar 2013 17:12:25 +0100
Subject: [RFC 2/5] rtc-at91rm9200: add device-tree support
In-Reply-To: <1364573029-19346-2-git-send-email-jhovold@gmail.com>
References: <1364573029-19346-1-git-send-email-jhovold@gmail.com>
 <1364573029-19346-2-git-send-email-jhovold@gmail.com>
Message-ID: <20130329161225.GC1166@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 05:03:46PM +0100, Johan Hovold wrote:
> Add device tree support.
> ---
>  drivers/rtc/rtc-at91rm9200.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index 5bae0a1..67260f9 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -28,6 +28,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/completion.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -255,9 +256,30 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
>  static const struct at91_rtc_config at91rm9200_config = {
>  };
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_rtc_dt_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-rtc",
> +		.data = &at91rm9200_config,
>+	},

There's a missing brace here. Will fix after any further feedback.

> +		/* terminator */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
> +#endif
