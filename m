From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 May 2011 20:44:38 +0200
Subject: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
In-Reply-To: <91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>
	<91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
Message-ID: <201105132044.39163.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 May 2011, Mike Rapoport wrote:
> @@ -299,17 +299,14 @@ static struct omap2_hsmmc_info mmc[] = {
>  static struct gpio_led igep_gpio_leds[] = {
>         [0] = {
>                 .name                   = "gpio-led:red:d0",
> -               .gpio                   = IGEP2_GPIO_LED0_RED,
>                 .default_trigger        = "default-off"
>         },
>         [1] = {
>                 .name                   = "gpio-led:green:d0",
> -               .gpio                   = IGEP2_GPIO_LED0_GREEN,
>                 .default_trigger        = "default-off",
>         },
>         [2] = {
>                 .name                   = "gpio-led:red:d1",
> -               .gpio                   = IGEP2_GPIO_LED1_RED,
>                 .default_trigger        = "default-off",
>         },
>         [3] = {
> @@ -335,6 +332,10 @@ static struct platform_device igep_led_device = {
>  
>  static void __init igep_leds_init(void)
>  {
> +       igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
> +       igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
> +       igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
> +
>         platform_device_register(&igep_led_device);
>  }

Hi Mike,

Overall, the series looks great, but I'm somewhat worried by the fact that you
have to replace data structures with code in order to get there. Are there any
other options to do this?

	Arnd
