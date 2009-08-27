From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 27 Aug 2009 15:35:37 +0200
Subject: [PATCH 5/5] PalmGSM: add basic Centro support
In-Reply-To: <1251333811-22360-6-git-send-email-sleep_walker@suse.cz>
References: <1251333811-22360-1-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-5-git-send-email-sleep_walker@suse.cz>
	<1251333811-22360-6-git-send-email-sleep_walker@suse.cz>
Message-ID: <200908271535.37959.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 27. srpna 2009 02:43:31 Tom?? ?ech napsal(a):
> From: Tom?? ?ech <sleep walker@suse.cz>
>
> ---
...
> +	{
> +		.name			= "centro:green:led",
> +		.default_trigger	= "mmc0",
> +		.gpio			= GPIO_NR_PALMGSM_GREEN_LED,
> +	},
> +	{
> +		.name			= "centro:keybbl:keybbl",

Should be 'centro:white:keybbl' I think...see Documentation/leds-class.txt
> +		.default_trigger	= "none",
> +		.active_low		= 1,
> +		.gpio			= GPIO_NR_CENTRO_KEYB_BL,
> +	},

And there is also that red led on the device, does it work already too?
> +};
> +
> +static struct gpio_led_platform_data centro_gpio_led_info = {
> +	.leds		= centro_gpio_leds,
> +	.num_leds	= ARRAY_SIZE(centro_gpio_leds),
> +};
...
