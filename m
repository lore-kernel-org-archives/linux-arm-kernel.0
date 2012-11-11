From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 11 Nov 2012 15:03:49 -0700
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1352650891-18356-2-git-send-email-andrew@lunn.ch>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
Message-ID: <50A020C5.4070506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 09:21 AM, Andrew Lunn wrote:
> From: Jamie Lentin <jm@lentin.co.uk>
> 
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low to power down
> your board.

This feature will be useful for the Tegra TrimSlice board too.

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt

> +Required properties:
> +- compatible : should be "gpio-poweroff".
> +- gpios : The GPIO to set high/low, see "gpios property" in
> +  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
> +  low to power down the board set it to "Active Low", otherwise set
> +  gpio to "Active High".

Unfortunately, not all GPIO bindings support active high/low flags in
the GPIO specifier. As such, the flags there are basically useless.
Other bindings (e.g. IIRC the fixed-regulator binding) have added a
separate active-high property to indicate the GPIO polarity. This
binding should probably follow suite.
