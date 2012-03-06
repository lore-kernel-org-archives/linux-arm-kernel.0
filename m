From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2012 13:38:00 -0800
Subject: [PATCH] ARM: OMAP: WiLink platform data for the PandaBoard
In-Reply-To: <1330994797-17298-1-git-send-email-mgherzan@gmail.com>
References: <1330994797-17298-1-git-send-email-mgherzan@gmail.com>
Message-ID: <20120306213800.GZ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Mircea Gherzan <mgherzan@gmail.com> [120305 16:15]:
> The "uim" deamon requires sysfs entries that are filled in using
> this platform data.
> 
> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   23 +++++++++++++++++------
>  include/linux/ti_wilink_st.h           |    2 ++
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index b1d74d6..37b437f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -27,6 +27,7 @@
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
> +#include <linux/ti_wilink_st.h>
>  #include <linux/wl12xx.h>
>  
>  #include <mach/hardware.h>
> @@ -56,15 +57,29 @@
>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
>  
>  /* wl127x BT, FM, GPS connectivity chip */
> -static int wl1271_gpios[] = {46, -1, -1};
> +static struct ti_st_plat_data wilink_platform_data = {
> +        .nshutdown_gpio	= 46,
> +        .dev_name	= "/dev/ttyO1",
> +        .flow_cntrl	= 1,
> +        .baud_rate	= 3000000,
> +	.chip_enable	= NULL,
> +        .suspend	= NULL,
> +        .resume		= NULL,
> +};
> +

Please use tabs above before .xxx instead of spaces.

> +static struct platform_device btwilink_device = {
> +	.name	= "btwilink",
> +	.id	= -1,
> +};
> +
>  static struct gpio_led gpio_leds[] = {
>  	{
>  		.name			= "pandaboard::status1",
> @@ -91,10 +106,6 @@ static struct platform_device leds_gpio = {
>  	},
>  };
>  
> -static struct platform_device btwilink_device = {
> -	.name	= "btwilink",
> -	.id	= -1,
> -};

This change is probably not needed, right?

Regards,

Tony
