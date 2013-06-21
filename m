From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 15:34:01 -0600
Subject: [PATCH v1 04/12] input: matrix-keypad: push/pull,
 separate polarity
In-Reply-To: <1371838198-7327-5-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-5-git-send-email-gsi@denx.de>
Message-ID: <51C4C6C9.6030000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> extend the device tree adjustable hardware configuration:
> - allow for differing polarity of the row and column GPIO pins
> - optionally fully drive column output pins instead of the former
>   unconditional open collector emulation approach

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> +- row-gpios-activelow:	row GPIO pins are active low
> +- col-gpios-activelow:	column GPIO pins are active low
>  - gpio-activelow:	row pins as well as column pins are active low
> +			(provided for backward compatibility, and useful
> +			for matrix layouts of identical polarity for
> +			rows and columns)

Those should all come from the existing GPIO flags, and may even differ
for each GPIO.

> +- col-gpios-pushpull:	fully drive the column selection pins in either
> +			direction (high and low signals), the default
> +			behaviour is to actively drive low signals and
> +			be passive otherwise (emulates an open collector
> +			output driver)

We don't actually have GPIO flags defined for pushpull-vs-open-collector
etc. Perhaps we should do so. Then, we wouldn't need to invent custom
properties to represent that in this binding.
