From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 07 Jun 2013 15:39:41 +0400
Subject: [PATCH 07/11] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <1370593329-27559-8-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
 <1370593329-27559-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51B1C67D.7040900@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-06-2013 12:22, Simon Horman wrote:

> The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> support them.

> Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/board-lager.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index 6114edd..6a1ba38 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -21,13 +21,37 @@
[...]
> +static struct gpio_led_platform_data lager_leds_pdata = {

     Misses __initdata. Too late now, need another patch...

> +	.leds		= lager_leds,
> +	.num_leds	= ARRAY_SIZE(lager_leds),
> +};
> +
>   static const struct pinctrl_map lager_pinctrl_map[] = {
>   	/* SCIF0 (CN19: DEBUG SERIAL0) */
>   	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
> @@ -46,6 +70,9 @@ static void __init lager_add_standard_devices(void)
>   	r8a7790_pinmux_init();
>
>   	r8a7790_add_standard_devices();
> +	platform_device_register_data(&platform_bus, "leds-gpio", -1,
> +				      &lager_leds_pdata,
> +				      sizeof(lager_leds_pdata));
>   }
>
>   static const char *lager_boards_compat_dt[] __initdata = {

WBR, Sergei
