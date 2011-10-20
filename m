From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 20 Oct 2011 08:28:58 +0200
Subject: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
In-Reply-To: <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201110200828.59278.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 October 2011 18:18:54 Maxime Ripard wrote:
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c
> b/arch/arm/mach-at91/at91sam9260_devices.c index 39f81f4..4f5e0f9 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> [...]
> +static struct platform_device at91_adc_device = {
> +	.name		= "at91adc",
> +	.id		= -1,
> +	.dev		= {
> +				.platform_data		= &adc_data,
> +	},
> +	.resource	= adc_resources,
> +	.num_resources	= ARRAY_SIZE(adc_resources),
> +};
> +
> +void __init at91_add_device_adc(struct at91_adc_data *data)
> +{
> +	if (!data)
> +		return;
> +
> +	at91_set_A_periph(AT91_PIN_PC0, 0);
> +	at91_set_A_periph(AT91_PIN_PC1, 0);
> +	at91_set_A_periph(AT91_PIN_PC2, 0);
> +	at91_set_A_periph(AT91_PIN_PC3, 0);
> +
> +	adc_data = *data;
> +	platform_device_register(&at91_adc_device);
> +}
> +
> +

This assumes that all 4 channels are used every time.  How about only using an 
AD channel on PC2 or all but the one on PC1?

Regards,
Alexander
