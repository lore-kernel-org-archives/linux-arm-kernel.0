From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jul 2016 09:05:46 -0500
Subject: [PATCH] gpio: document how to order GPIO controllers
In-Reply-To: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1467355333-8813-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160705140546.GA10601@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 08:42:13AM +0200, Uwe Kleine-K?nig wrote:
> This uses the same approach that is already used for spi, i2c and
> several other controllers to ensure a consistent numbering independent
> of probe order. This is in use for several gpio drivers that already now
> use of_alias_get_id(np, "gpio").

Like SPI and I2C, I'm against further abuse of aliases for this purpose 
[1].

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> Linus requested such a patch as part of a change that introduces
> this mechanism to the gpio-omap driver[1]. IMHO this is better done in a
> separate patch, so here it comes.
> 
> Best regards
> Uwe
> 
> [1] http://thread.gmane.org/gmane.linux.kernel.gpio/17399/focus=17629
> 
>  Documentation/devicetree/bindings/gpio/gpio.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
> index 68d28f62a6f4..5dbacc8f094a 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -227,6 +227,24 @@ Example of two SOC GPIO banks defined as gpio-controller nodes:
>  		#gpio-cells = <2>;
>  	};
>  
> +Usually the GPIO banks in SoCs are ordered, that is there is a dedicated "first
> +gpio bank". To fix this ordering in the device tree use aliases starting at 0
> +(even if the first bank is called "GPIO1" in the hardware reference).
> +This is necessary/handy to ensure deterministical numbering of GPIOs and GPIO
> +controllers.

Why is deterministic numbering needed?

Rob

[1] https://lkml.org/lkml/2016/5/24/470
