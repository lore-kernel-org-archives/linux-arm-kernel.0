From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 11 Jan 2010 14:06:31 +1300
Subject: [PATCH] ep93xx: use pr_fmt in core.c
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200F638@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F638@mi8nycmail19.Mi8.com>
Message-ID: <4B4A7997.2030002@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Use pr_fmt to prefix kernel output with the module name.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 1f0d665..41064bd 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -14,6 +14,8 @@
>   * your option) any later version.
>   */
>  
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -318,8 +320,7 @@ static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
>  		desc->handle_irq = handle_edge_irq;
>  		break;
>  	default:
> -		pr_err("ep93xx: failed to set irq type %d for gpio %d\n",
> -		       type, gpio);
> +		pr_err("failed to set irq type %d for gpio %d\n", type, gpio);
>  		return -EINVAL;
>  	}
>  
> @@ -572,9 +573,9 @@ void __init ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
>  	 * CMOS driver.
>  	 */
>  	if (data->sda_is_open_drain && data->sda_pin != EP93XX_GPIO_LINE_EEDAT)
> -		pr_warning("ep93xx: sda != EEDAT, open drain has no effect\n");
> +		pr_warning("sda != EEDAT, open drain has no effect\n");
>  	if (data->scl_is_open_drain && data->scl_pin != EP93XX_GPIO_LINE_EECLK)
> -		pr_warning("ep93xx: scl != EECLK, open drain has no effect\n");
> +		pr_warning("scl != EECLK, open drain has no effect\n");
>  
>  	__raw_writel((data->sda_is_open_drain << 1) |
>  		     (data->scl_is_open_drain << 0), 

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
