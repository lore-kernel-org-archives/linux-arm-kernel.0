From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 8 Jul 2012 13:29:03 +0200
Subject: [PATCH 14/15] i2c: iop3xx: use standard gpiolib functions
In-Reply-To: <1341600040-30993-15-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-15-git-send-email-robherring2@gmail.com>
Message-ID: <20120708112903.GB18362@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 01:40:39PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Instead of using the custom iop3xx gpio functions, use the gpiolib
> variants. This should be functionally the same since the gpiolib
> just calls the iop3xx gpio functions. This is needed in preparation
> of removing iop3xx mach/io.h headers.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
> Cc: "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>
> Cc: linux-i2c at vger.kernel.org

Is this dependent on another patch from this series? Or can this go
via the I2C tree? I am fine with just acking this one, but the
whitespace removal should better go via I2C I think.

Thanks,

   Wolfram

> ---
>  drivers/i2c/busses/i2c-iop3xx.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
> index 567d873..2f99613 100644
> --- a/drivers/i2c/busses/i2c-iop3xx.c
> +++ b/drivers/i2c/busses/i2c-iop3xx.c
> @@ -39,6 +39,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include "i2c-iop3xx.h"
>  
> @@ -78,11 +79,11 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
>  	 */
>  #if defined(CONFIG_ARCH_IOP32X) || defined(CONFIG_ARCH_IOP33X)
>  	if (iop3xx_adap->id == 0) {
> -		gpio_line_set(IOP3XX_GPIO_LINE(7), GPIO_LOW);
> -		gpio_line_set(IOP3XX_GPIO_LINE(6), GPIO_LOW);
> +		gpio_set_value(7, 0);
> +		gpio_set_value(6, 0);
>  	} else {
> -		gpio_line_set(IOP3XX_GPIO_LINE(5), GPIO_LOW);
> -		gpio_line_set(IOP3XX_GPIO_LINE(4), GPIO_LOW);
> +		gpio_set_value(5, 0);
> +		gpio_set_value(4, 0);
>  	}
>  #endif
>  	/* NB SR bits not same position as CR IE bits :-( */
> -- 
> 1.7.9.5
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120708/d79ddf16/attachment-0001.sig>
