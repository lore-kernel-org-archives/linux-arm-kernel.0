From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 27 Sep 2016 17:12:07 +0200
Subject: [PATCHv3 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
In-Reply-To: <20160927141313.27668-2-richard.genoud@gmail.com>
References: <20160927141313.27668-1-richard.genoud@gmail.com>
 <20160927141313.27668-2-richard.genoud@gmail.com>
Message-ID: <20160927151207.owivtd7ruvgmexu7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Sep 27, 2016 at 04:13:11PM +0200, Richard Genoud wrote:
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index d2da6aa7f27d..0e5525a64c2a 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/irq.h>
> +#include <linux/err.h>

this isn't needed any more, right?

>  #include <linux/gpio/consumer.h>
>  #include <linux/termios.h>
>  #include <linux/serial_core.h>
> @@ -72,6 +73,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>  
> +bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
> +{
> +	return mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS) &&
> +		mctrl_gpio_to_gpiod(gpios, UART_GPIO_RTS);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_use_rtscts);
> +
>  unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
>  {
>  	enum mctrl_gpio_idx i;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
