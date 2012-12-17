From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Dec 2012 12:10:26 +0000
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50CF0744.7040404@grandegger.com>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com> <50CBBB25.20002@antcom.de>
 <50CF03FB.2030100@grandegger.com> <50CF0744.7040404@grandegger.com>
Message-ID: <20121217121026.GR14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 12:51:32PM +0100, Wolfgang Grandegger wrote:
> +static void at91_gpiolib_set_block(struct gpio_chip *chip, unsigned long mask, unsigned long val)
> +{
> +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> +	void __iomem *pio = at91_gpio->regbase;
> +	u32 set_bits = val & mask;
> +	u32 clr_bits = ~val & mask;
> +
> +	/* GPIO outputs can only be set at once or cleared at once */
> +	if (set_bits)
> +		__raw_writel(set_bits, pio + PIO_SODR);
> +	if (clr_bits)
> +		__raw_writel(clr_bits, pio + PIO_CODR);
> +}

You obviously didn't see my email...
