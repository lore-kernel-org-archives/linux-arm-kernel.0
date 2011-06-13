From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 09:23:01 +0100
Subject: [PATCH 5/6] arm: footbridge: convert old leds event driver to
	led gpio trigger driver of Netwinder
In-Reply-To: <1307947185-5159-6-git-send-email-bryan.wu@canonical.com>
References: <1307947185-5159-1-git-send-email-bryan.wu@canonical.com>
	<1307947185-5159-6-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110613082301.GB9393@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 02:39:44PM +0800, Bryan Wu wrote:
> +/* LEDs */
> +static struct gpio_led nw_gpio_leds[] = {
> +        {
> +                .name                   = "netwinder::led_red",
> +                .default_trigger        = "heartbeat",
> +                .gpio                   = GPIO_RED_LED,
> +        },
> +        {
> +                .name                   = "netwinder::led_green",
> +                .default_trigger        = "timer",
> +                .gpio                   = GPIO_GREEN_LED,
> +        },

This is especially broken.  This platform has no GPIO support other
than its private stuff, which makes the use of the GPIO LED driver
useless.  The GPIO_*_LED constants are bitmasks for the CPLD
controller.
